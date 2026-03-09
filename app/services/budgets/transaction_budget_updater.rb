# app/services/budgets/transaction_budget_updater.rb
module Budgets
  class TransactionBudgetUpdater
    ALERT_THRESHOLD_RATIO = 0.8

    def initialize(transaction, operation:, category: nil)
      @transaction    = transaction
      @wallet         = @transaction.base_wallet
      @category       = category || transaction.category
      @op             = operation
    end

    def call
      return unless expense? && @wallet.type == "Wallet" && @wallet.budgets.exists?(category: @category)

      delta = compute_delta
      return if delta.zero?

      @wallet.budgets.where(category: @category, status: :on_going).find_each do |budget|

        return unless @transaction.executed_at.month == budget.created_at.to_date.month

        unit = budget.budget_units.order(created_at: :desc).first

        old_amt = unit.spent_amount_cents
        new_amt = old_amt + delta
        new_amt = 0 if new_amt < 0
        unit.update!(spent_amount_cents: new_amt)

        if delta.positive?
          @wallet.group.members.each do |member|

            check_and_alert(budget, old_amt, new_amt, member)
          end
        end
      end
    end

    private

    def expense?
      @transaction.Despesa?
    end

    def compute_delta
      case @op
      when :add
        +@transaction.amount_cents
      when :remove
        -@transaction.amount_cents
      when :update
        old, new = @transaction.saved_change_to_amount_cents
        new - old
      else
        0
      end
    end

    def check_and_alert(budget, old_amt, new_amt, member)
      return if member.user.nil?
      threshold = (budget.max_amount_cents * ALERT_THRESHOLD_RATIO).to_i

      if new_amt >= budget.max_amount_cents
        BudgetMailer.with(user: member.user, budget: budget).budget_exceeded_alert.deliver_now

      elsif old_amt < threshold && new_amt >= threshold
        BudgetMailer.with(user: member.user, budget: budget).budget_alert.deliver_now
      end
    end
  end
end

# == Schema Information
#
# Table name: budget_units
#
#  id                 :uuid             not null, primary key
#  max_amount_cents   :integer          default(0), not null
#  spent_amount_cents :integer          default(0), not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  budget_id          :uuid             not null
#  category_id        :uuid             not null
#
# Indexes
#
#  index_budget_units_on_budget_id    (budget_id)
#  index_budget_units_on_category_id  (category_id)
#
# Foreign Keys
#
#  fk_rails_...  (budget_id => budgets.id)
#  fk_rails_...  (category_id => categories.id)
#
class BudgetUnit < ApplicationRecord

  # == Includes =============================================================

  # == Constants ============================================================

  # == Attributes ===========================================================
  attr_accessor :skip_transaction_sum

  # == Extensions ===========================================================
  monetize :max_amount_cents

  # == Relationships ========================================================
  belongs_to :budget
  belongs_to :category

  # == Validations ==========================================================
  validates :max_amount_cents, presence: true

  # == Scopes ===============================================================
  before_create :add_transactions_to_unit, unless: :skip_transaction_sum

  # == Callbacks ============================================================

  # == Class Methods ========================================================

  # == Instance Methods =====================================================
  private
  def add_transactions_to_unit
    sum = 0
    budget.wallet.transactions.each do |transaction|
      budget_date = budget.created_at.to_date
      if transaction.executed_at.month == budget_date.month
        sum += transaction.amount_cents if transaction.Despesa?
      end
    end
    self.spent_amount_cents = sum
  end
end

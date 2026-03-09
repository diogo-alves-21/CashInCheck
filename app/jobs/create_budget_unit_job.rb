class CreateBudgetUnitJob < ApplicationJob
  def perform
    today = Date.current
    return unless today.day == 1

    create_units_for Budget.monthly_unit

    create_units_for(Budget.annual_unit) if today.month == 1
  end

  private

  def create_units_for(scope)
    scope.find_each do |budget|

      budget.update!(status: :on_going) if budget.archived_status?

      unit = budget.budget_units.new(
        category:          budget.category,
        max_amount_cents:  budget.max_amount_cents
      )
      unit.skip_transaction_sum = true
      unit.save!
    end
  end
end


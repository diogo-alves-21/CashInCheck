class RemoveCurrentAmountFromBudget < ActiveRecord::Migration[8.0]
  def up
    remove_column :budgets, :current_amount_cents
  end

  def down
    add_monetize :budgets, :current_amount, currency: { present: false }, default:0
  end
end

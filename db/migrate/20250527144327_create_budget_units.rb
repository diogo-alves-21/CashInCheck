class CreateBudgetUnits < ActiveRecord::Migration[8.0]
  def change
    create_table :budget_units, id: :uuid do |t|
      t.monetize :max_amount, currency: { present: false }
      t.monetize :spent_amount, currency: { present: false }, default: 0
      t.references :budget, type: :uuid, null: false, foreign_key: true
      t.references :category, type: :uuid, null: false, foreign_key: true
      t.timestamps
    end
  end
end

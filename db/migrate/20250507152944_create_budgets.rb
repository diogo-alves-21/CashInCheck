class CreateBudgets < ActiveRecord::Migration[8.0]
  def change
    create_table :budgets, id: :uuid do |t|
      t.string :name, null: false, limit: 50
      t.integer :unit, null: false, default: 0
      t.monetize :max_amount, currency: { present: false }
      t.monetize :current_amount, currency: { present: false }, default:0
      t.string :currency, null: false, default: 'EUR'
      t.text :description, null: true, default: nil
      t.references :group, foreign_key: true, null: false, type: :uuid
      t.references :category, foreign_key: true, null: false, type: :uuid
      t.references :wallet, foreign_key: true, null: false, type: :uuid
      t.timestamps
    end
  end
end

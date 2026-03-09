class CreateTransactions < ActiveRecord::Migration[8.0]
  def change
    create_table :transactions, id: :uuid do |t|
      t.integer :kind, null: false
      t.integer :amount, null: false
      t.date :executed_at, null: false
      t.text :description, null: false, default: ''
      t.references :wallet, null: false, foreign_key: true, type: :uuid
      t.references :category, null: false, foreign_key: true, type: :uuid
      t.references :payer, null: false, foreign_key: {to_table: :members}, type: :uuid
      t.timestamps
    end
  end
end

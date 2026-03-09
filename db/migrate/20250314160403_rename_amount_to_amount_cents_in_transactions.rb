class RenameAmountToAmountCentsInTransactions < ActiveRecord::Migration[8.0]
  def up
    remove_column :transactions, :amount
    add_monetize :transactions, :amount, currency: { default: 'EUR' }
  end

  def down
    add_column :transactions, :amount, :integer
    remove_column :transactions, :amount_cents_cents
    remove_column :transactions, :amount_cents_currency
  end
end

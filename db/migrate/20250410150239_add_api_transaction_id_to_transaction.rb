class AddApiTransactionIdToTransaction < ActiveRecord::Migration[8.0]
  def up
    add_column :transactions, :api_transaction_id, :string, null: true, default: nil
    add_index :transactions, :api_transaction_id, unique: true
  end

  def down
    remove_index :transactions, :api_transaction_id
    remove_column :transactions, :api_transaction_id
  end
end

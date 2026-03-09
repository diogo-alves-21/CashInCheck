class RemoveUniqueIndexFromApiTransactionId < ActiveRecord::Migration[8.0]
  def up
    remove_index :transactions, :api_transaction_id
  end

  def down
    add_index :transactions, :api_transaction_id, unique: true
  end
end

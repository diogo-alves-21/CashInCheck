class AddFromApiToTransactions < ActiveRecord::Migration[8.0]
  def change
    add_column :transactions, :from_api, :boolean, null: false, default: false
    add_column :wallets, :account_id, :string, null: true, default: nil
  end
end

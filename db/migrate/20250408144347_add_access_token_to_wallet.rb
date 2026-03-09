class AddAccessTokenToWallet < ActiveRecord::Migration[8.0]
  def up
    add_column :wallets, :api_access_token, :string
    add_column :wallets, :kind, :integer
    add_index :wallets, :api_access_token
  end

  def down
    remove_index :wallets, :api_access_token
    remove_column :wallets, :kind
    remove_column :wallets, :api_access_token
  end
end

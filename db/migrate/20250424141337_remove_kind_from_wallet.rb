class RemoveKindFromWallet < ActiveRecord::Migration[8.0]
  def up
    remove_column :wallets, :kind
  end

  def down
    add_column :wallets, :kind, :integer
  end
end

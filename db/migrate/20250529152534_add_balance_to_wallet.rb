class AddBalanceToWallet < ActiveRecord::Migration[8.0]
  def change
    add_monetize :wallets, :balance, currency: {present: false}, default: 0, null: false
  end
end

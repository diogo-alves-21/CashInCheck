class RenameWalletTableName < ActiveRecord::Migration[8.0]
  def up
    rename_table :wallets, :base_wallets
    add_column :base_wallets, :type, :string, default: "Wallet"
    add_column :base_wallets, :status, :integer, default: 0, null: false
    drop_table :goals
  end

  def down
    remove_column :base_wallets, :type
    remove_column :base_wallets, :status
    rename_table :base_wallets, :wallets
    create_table :goals, id: :uuid do |t|
      t.string :name, null: false, limit: 50
      t.monetize :current_amount, currency: { present: false }, default: 0
      t.monetize :target_amount, currency: { present: false }
      t.string :currency, null: false, default: 'EUR'
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.text :description, null: true, default: nil
      t.integer :status, null: false, default: 0
      t.references :group, null: false, foreign_key: true, type: :uuid
      t.timestamps
    end
  end
end

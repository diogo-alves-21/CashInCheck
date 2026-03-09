class AlterNamesOfManyToManyTables < ActiveRecord::Migration[8.0]
  def up
    rename_table :members_transactions, :member_transactions
    rename_table :tags_transactions, :tag_transactions
  end
  def down
    rename_table :member_transactions, :members_transactions
    rename_table :tag_transactions, :tags_transactions
  end
end

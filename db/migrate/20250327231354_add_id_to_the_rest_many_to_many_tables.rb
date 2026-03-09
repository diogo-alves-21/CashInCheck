class AddIdToTheRestManyToManyTables < ActiveRecord::Migration[8.0]
  def up
    add_column :member_transactions, :id, :uuid, default: "gen_random_uuid()"
    execute "ALTER TABLE member_transactions ADD PRIMARY KEY (id);"

    add_column :tag_transactions, :id, :uuid, default: "gen_random_uuid()"
    execute "ALTER TABLE tag_transactions ADD PRIMARY KEY (id);"
  end

  def down
    remove_column :member_transactions, :id
    remove_column :tag_transactions, :id
  end
end

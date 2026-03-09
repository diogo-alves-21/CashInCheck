class AddIdToGroupMembers < ActiveRecord::Migration[8.0]
  def up
    add_column :group_members, :id, :uuid, default: "gen_random_uuid()"
    execute "ALTER TABLE group_members ADD PRIMARY KEY (id);"
  end

  def down
    remove_column :group_members, :id
  end
end

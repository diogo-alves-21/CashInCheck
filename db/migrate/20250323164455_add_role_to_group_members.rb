class AddRoleToGroupMembers < ActiveRecord::Migration[8.0]
  def up
    add_column :groups_members, :role, :integer, default: 0, null: false
  end

  def down
    remove_column :groups_members, :role
  end
end

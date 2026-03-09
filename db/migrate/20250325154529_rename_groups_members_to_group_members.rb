class RenameGroupsMembersToGroupMembers < ActiveRecord::Migration[8.0]
  def up
    rename_table :groups_members, :group_members
  end
  def down
    rename_table :group_members, :groups_members
  end
end

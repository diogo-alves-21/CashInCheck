class AddNullUserIdToMembers < ActiveRecord::Migration[8.0]
  def up
    change_column :members, :user_id, :uuid, null: true
  end

  def down
    change_column :members, :user_id, :uuid, null: false
  end
end

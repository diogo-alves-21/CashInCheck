class CreateGroupsMembers < ActiveRecord::Migration[8.0]
  def change
    create_table :groups_members, id: false do |t|
      t.references :group, type: :uuid, null: false, foreign_key: true
      t.references :member, type: :uuid, null: false, foreign_key: true
    end
  end
end

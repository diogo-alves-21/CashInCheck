class CreateMembers < ActiveRecord::Migration[8.0]
  def change
    create_table :members, id: :uuid do |t|
      t.string :name, null: false, default: ""
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.timestamps
    end
  end
end

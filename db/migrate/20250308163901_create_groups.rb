class CreateGroups < ActiveRecord::Migration[8.0]
  def change
    create_table :groups, id: :uuid do |t|
      t.string :name , null: false, default: ""
      t.timestamps
    end
  end
end

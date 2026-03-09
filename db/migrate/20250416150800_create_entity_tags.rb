class CreateEntityTags < ActiveRecord::Migration[8.0]
  def change
    create_table :entity_tags, id: :uuid do |t|
      t.references :group, type: :uuid, null: false, foreign_key: true
      t.references :tag, type: :uuid, null: false, foreign_key: true
      t.string :api_entity_id, null: false
      t.timestamps
    end

    add_index :entity_tags, [:api_entity_id, :group_id], unique: true
  end
end

class CreateEntities < ActiveRecord::Migration[8.0]
  def change
    create_table :entity_categories, id: :uuid do |t|
      t.references :category, null: false, foreign_key: true, type: :uuid
      t.references :group, null: false, foreign_key: true, type: :uuid
      t.string :api_entity_id, null: false
      t.timestamps
    end

    add_index :entity_categories, [:api_entity_id, :group_id], unique: true
  end

end

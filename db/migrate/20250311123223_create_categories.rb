class CreateCategories < ActiveRecord::Migration[8.0]
  def change
    create_table :categories, id: :uuid do |t|
      t.string :name, null: false, limit: 50
      t.references :group, null: false, foreign_key: true, type: :uuid
      t.timestamps
    end
  end
end

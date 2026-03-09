class AlterCategoryIdAndCategoryName < ActiveRecord::Migration[8.0]
  def up
    change_column :transactions, :category_id, :uuid, null: true
  end

  def down
    change_column :transactions, :category_id, :uuid, null: false
  end
end

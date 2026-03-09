class AddEntityIdToTransactions < ActiveRecord::Migration[8.0]
  def up
    add_column :transactions, :entity_id, :string, null: true
    add_column :transactions, :entity_name, :string, null: true
  end

  def down
    remove_column :transactions, :entity_id
    remove_column :transactions, :entity_name
  end
end

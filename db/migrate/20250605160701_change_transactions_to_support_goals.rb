class ChangeTransactionsToSupportGoals < ActiveRecord::Migration[8.0]
  def up
    change_column :transactions, :category_id, :uuid, null: true
    change_column :transactions, :payer_id, :uuid, null: true
    change_column :transactions, :description, :text, null: true
  end
end

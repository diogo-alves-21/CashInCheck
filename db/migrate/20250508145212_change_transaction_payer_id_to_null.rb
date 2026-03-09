class ChangeTransactionPayerIdToNull < ActiveRecord::Migration[8.0]
  def up
    change_column :transactions, :payer_id, :uuid, null: true, default: nil
  end

  def down
    change_column :transactions, :payer_id, :uuid, null: false
  end
end

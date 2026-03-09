class CreateMemberTransaction < ActiveRecord::Migration[8.0]
  def change
    create_table :members_transactions, id: false do |t|
      t.references :payee, null: false, foreign_key: { to_table: :members }, type: :uuid
      t.references :transaction, null: false, foreign_key: true, type: :uuid
    end
  end
end

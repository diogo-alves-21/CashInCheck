class CreateTagsTransactions < ActiveRecord::Migration[8.0]
  def change
    create_table :tags_transactions, id: false do |t|
      t.references :tag, null: false, foreign_key: true, type: :uuid
      t.references :transaction, null: false, foreign_key: true, type: :uuid
    end
  end
end

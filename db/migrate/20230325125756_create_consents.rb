class CreateConsents < ActiveRecord::Migration[6.1]
  def change
    create_table :consents, id: :uuid do |t|
      t.string :version, null: false, default: ''
      t.integer :kind, null: false, default: 0
      t.boolean :active, null: false, default: false

      t.timestamps
    end
  end
end

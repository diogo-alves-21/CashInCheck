class CreateAcceptedConsents < ActiveRecord::Migration[6.1]
  def change
    create_table :accepted_consents, id: :uuid do |t|
      t.inet :ip
      t.references :consent, null: false, foreign_key: true, type: :uuid
      t.references :acceptable, null: false, polymorphic: true, type: :uuid

      t.timestamps
    end
  end
end

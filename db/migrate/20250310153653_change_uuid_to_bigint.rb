class ChangeUuidToBigint < ActiveRecord::Migration[8.0]
  def up
    remove_foreign_key :members, :users
    remove_foreign_key :groups_members, :groups
    remove_foreign_key :groups_members, :members

    drop_table :users
    drop_table :members
    drop_table :groups
    drop_table :groups_members

    create_table :users, id: :uuid do |t|
      t.string :email, null: false, limit: 100
      t.string :encrypted_password, null: false

      t.string   :reset_password_token
      t.datetime :reset_password_sent_at
      t.datetime :remember_created_at

      t.timestamps null: false
    end

    add_index :users, :email, unique: true
    add_index :users, :reset_password_token, unique: true

    create_table :members, id: :uuid do |t|
      t.string :name, null: false, limit: 50
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.timestamps
    end

    create_table :groups, id: :uuid do |t|
      t.string :name, null: false, limit: 50
      t.timestamps
    end

    create_table :groups_members, id: false do |t|
      t.references :group, type: :uuid, null: false, foreign_key: true
      t.references :member, type: :uuid, null: false, foreign_key: true
    end

  end

  def down

    remove_foreign_key :members, :users
    remove_foreign_key :groups_members, :groups
    remove_foreign_key :groups_members, :members

    drop_table :users
    drop_table :members
    drop_table :groups
    drop_table :groups_members

    create_table :users do |t|
      t.string :email, null: false, limit: 100
      t.string :encrypted_password, null: false

      t.string   :reset_password_token
      t.datetime :reset_password_sent_at
      t.datetime :remember_created_at

      t.timestamps null: false
    end

    add_index :users, :email, unique: true
    add_index :users, :reset_password_token, unique: true

    create_table :members do |t|
      t.string :name, null: false, limit: 50
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end

    create_table :groups do |t|
      t.string :name, null: false, limit: 50
      t.timestamps
    end

    create_table :groups_members, id: false do |t|
      t.references :group, null: false, foreign_key: true
      t.references :member, null: false, foreign_key: true
    end

  end
end

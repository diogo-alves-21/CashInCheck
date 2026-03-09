# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_06_18_142154) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "accepted_consents", force: :cascade do |t|
    t.inet "ip"
    t.bigint "consent_id", null: false
    t.string "acceptable_type", null: false
    t.bigint "acceptable_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["acceptable_type", "acceptable_id"], name: "index_accepted_consents_on_acceptable"
    t.index ["consent_id"], name: "index_accepted_consents_on_consent_id"
  end

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", precision: nil, null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: nil
    t.datetime "remember_created_at", precision: nil
    t.string "invitation_token"
    t.datetime "invitation_created_at", precision: nil
    t.datetime "invitation_sent_at", precision: nil
    t.datetime "invitation_accepted_at", precision: nil
    t.integer "invitation_limit"
    t.integer "invited_by_id"
    t.string "invited_by_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["invitation_token"], name: "index_admins_on_invitation_token", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "base_wallets", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", limit: 50, null: false
    t.text "description", default: "", null: false
    t.uuid "group_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "api_access_token"
    t.string "account_id"
    t.integer "balance_cents", default: 0, null: false
    t.string "balance_currency", default: "USD", null: false
    t.string "type", default: "Wallet"
    t.integer "status", default: 0, null: false
    t.date "start_date"
    t.date "end_date"
    t.integer "current_amount_cents", default: 0, null: false
    t.integer "target_amount_cents", default: 0, null: false
    t.string "currency", default: "EUR", null: false
    t.index ["api_access_token"], name: "index_base_wallets_on_api_access_token"
    t.index ["group_id"], name: "index_base_wallets_on_group_id"
  end

  create_table "budget_units", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "max_amount_cents", default: 0, null: false
    t.integer "spent_amount_cents", default: 0, null: false
    t.uuid "budget_id", null: false
    t.uuid "category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["budget_id"], name: "index_budget_units_on_budget_id"
    t.index ["category_id"], name: "index_budget_units_on_category_id"
  end

  create_table "budgets", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", limit: 50, null: false
    t.integer "unit", default: 0, null: false
    t.integer "max_amount_cents", default: 0, null: false
    t.string "currency", default: "EUR", null: false
    t.text "description"
    t.uuid "group_id", null: false
    t.uuid "category_id", null: false
    t.uuid "wallet_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0, null: false
    t.index ["category_id"], name: "index_budgets_on_category_id"
    t.index ["group_id"], name: "index_budgets_on_group_id"
    t.index ["wallet_id"], name: "index_budgets_on_wallet_id"
  end

  create_table "categories", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", limit: 50, null: false
    t.uuid "group_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_categories_on_group_id"
  end

  create_table "consents", force: :cascade do |t|
    t.string "version", default: "", null: false
    t.integer "kind", default: 0, null: false
    t.boolean "active", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "entity_categories", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "category_id", null: false
    t.uuid "group_id", null: false
    t.string "api_entity_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["api_entity_id", "group_id"], name: "index_entity_categories_on_api_entity_id_and_group_id", unique: true
    t.index ["category_id"], name: "index_entity_categories_on_category_id"
    t.index ["group_id"], name: "index_entity_categories_on_group_id"
  end

  create_table "entity_tags", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "group_id", null: false
    t.uuid "tag_id", null: false
    t.string "api_entity_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["api_entity_id", "group_id"], name: "index_entity_tags_on_api_entity_id_and_group_id", unique: true
    t.index ["group_id"], name: "index_entity_tags_on_group_id"
    t.index ["tag_id"], name: "index_entity_tags_on_tag_id"
  end

  create_table "group_members", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "group_id", null: false
    t.uuid "member_id", null: false
    t.integer "role", default: 0, null: false
    t.index ["group_id"], name: "index_group_members_on_group_id"
    t.index ["member_id"], name: "index_group_members_on_member_id"
  end

  create_table "groups", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", limit: 50, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "member_transactions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "payee_id", null: false
    t.uuid "transaction_id", null: false
    t.index ["payee_id"], name: "index_member_transactions_on_payee_id"
    t.index ["transaction_id"], name: "index_member_transactions_on_transaction_id"
  end

  create_table "members", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", limit: 50, null: false
    t.uuid "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_members_on_user_id"
  end

  create_table "tag_transactions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "tag_id", null: false
    t.uuid "transaction_id", null: false
    t.index ["tag_id"], name: "index_tag_transactions_on_tag_id"
    t.index ["transaction_id"], name: "index_tag_transactions_on_transaction_id"
  end

  create_table "tags", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", limit: 50, null: false
    t.uuid "group_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_tags_on_group_id"
  end

  create_table "transactions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "kind", null: false
    t.date "executed_at", null: false
    t.text "description", default: ""
    t.uuid "wallet_id", null: false
    t.uuid "category_id"
    t.uuid "payer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "amount_cents", default: 0, null: false
    t.string "amount_currency", default: "EUR", null: false
    t.string "api_transaction_id"
    t.string "entity_id"
    t.string "entity_name"
    t.boolean "from_api", default: false, null: false
    t.index ["category_id"], name: "index_transactions_on_category_id"
    t.index ["payer_id"], name: "index_transactions_on_payer_id"
    t.index ["wallet_id"], name: "index_transactions_on_wallet_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "email", limit: 100, null: false
    t.string "encrypted_password", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.string "invited_by_type"
    t.bigint "invited_by_id"
    t.integer "invitations_count", default: 0
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true
    t.index ["invited_by_id"], name: "index_users_on_invited_by_id"
    t.index ["invited_by_type", "invited_by_id"], name: "index_users_on_invited_by"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "accepted_consents", "consents"
  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "base_wallets", "groups"
  add_foreign_key "budget_units", "budgets"
  add_foreign_key "budget_units", "categories"
  add_foreign_key "budgets", "base_wallets", column: "wallet_id"
  add_foreign_key "budgets", "categories"
  add_foreign_key "budgets", "groups"
  add_foreign_key "categories", "groups"
  add_foreign_key "entity_categories", "categories"
  add_foreign_key "entity_categories", "groups"
  add_foreign_key "entity_tags", "groups"
  add_foreign_key "entity_tags", "tags"
  add_foreign_key "group_members", "groups"
  add_foreign_key "group_members", "members"
  add_foreign_key "member_transactions", "members", column: "payee_id"
  add_foreign_key "member_transactions", "transactions"
  add_foreign_key "members", "users"
  add_foreign_key "tag_transactions", "tags"
  add_foreign_key "tag_transactions", "transactions"
  add_foreign_key "tags", "groups"
  add_foreign_key "transactions", "base_wallets", column: "wallet_id"
  add_foreign_key "transactions", "categories"
  add_foreign_key "transactions", "members", column: "payer_id"
end

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_08_30_072111) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "groups", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.text "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "members", force: :cascade do |t|
    t.text "name"
    t.text "email"
    t.uuid "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_members_on_group_id"
  end

  create_table "settles", force: :cascade do |t|
    t.bigint "transaction_id"
    t.bigint "paid_for_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "income_id"
    t.index ["income_id"], name: "index_settles_on_income_id"
    t.index ["paid_for_id"], name: "index_settles_on_paid_for_id"
    t.index ["transaction_id"], name: "index_settles_on_transaction_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.integer "kind", default: 0
    t.text "description"
    t.decimal "amount"
    t.datetime "date"
    t.text "image"
    t.uuid "group_id"
    t.bigint "member_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_transactions_on_group_id"
    t.index ["member_id"], name: "index_transactions_on_member_id"
  end

  add_foreign_key "members", "groups"
  add_foreign_key "settles", "members", column: "paid_for_id"
  add_foreign_key "settles", "transactions"
  add_foreign_key "settles", "transactions", column: "income_id"
  add_foreign_key "transactions", "groups"
  add_foreign_key "transactions", "members"
end

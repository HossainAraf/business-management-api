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

ActiveRecord::Schema[8.1].define(version: 2025_11_15_232628) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"
  enable_extension "pgcrypto"

  # Custom types defined in this database.
  # Note that some types may not work with other database engines. Be careful if changing database.
  create_enum "bm_adjustment_type_enum", ["add", "remove"]
  create_enum "bm_stock_entry_type", ["purchase", "adjustment", "return"]

  create_table "bm_adjustments", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.enum "adjustment_type", null: false, enum_type: "bm_adjustment_type_enum"
    t.datetime "created_at", null: false
    t.uuid "item_id", null: false
    t.integer "quantity"
    t.text "reason"
    t.datetime "updated_at", null: false
  end

  create_table "bm_items", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "description"
    t.string "name"
    t.string "sku", null: false
    t.decimal "unit_price", precision: 10, scale: 2
    t.datetime "updated_at", null: false
    t.index ["sku"], name: "index_bm_items_on_sku", unique: true
  end

  create_table "bm_purchase_items", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.uuid "item_id", null: false
    t.uuid "purchase_id", null: false
    t.integer "quantity"
    t.decimal "total_price", precision: 12, scale: 2
    t.decimal "unit_price", precision: 10, scale: 2
    t.datetime "updated_at", null: false
  end

  create_table "bm_purchases", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.uuid "created_by"
    t.date "date"
    t.string "invoice_number", null: false
    t.string "supplier_name"
    t.decimal "total_amount", precision: 12, scale: 2
    t.datetime "updated_at", null: false
    t.index ["invoice_number"], name: "index_bm_purchases_on_invoice_number", unique: true
  end

  create_table "bm_sale_items", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.uuid "item_id", null: false
    t.integer "quantity"
    t.uuid "sale_id", null: false
    t.decimal "total_price", precision: 12, scale: 2
    t.decimal "unit_price", precision: 10, scale: 2
    t.datetime "updated_at", null: false
  end

  create_table "bm_sales", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.uuid "created_by"
    t.string "customer_name"
    t.date "date"
    t.string "invoice_number", null: false
    t.decimal "total_amount", precision: 12, scale: 2
    t.datetime "updated_at", null: false
    t.index ["invoice_number"], name: "index_bm_sales_on_invoice_number", unique: true
  end

  create_table "bm_stock_entries", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.uuid "created_by", null: false
    t.enum "entry_type", null: false, enum_type: "bm_stock_entry_type"
    t.uuid "item_id", null: false
    t.text "notes"
    t.integer "quantity", null: false
    t.string "source"
    t.datetime "updated_at", null: false
  end

  create_table "bm_users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", null: false
    t.string "name"
    t.string "password_digest"
    t.string "role"
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_bm_users_on_email", unique: true
  end

  add_foreign_key "bm_adjustments", "bm_items", column: "item_id"
  add_foreign_key "bm_purchase_items", "bm_items", column: "item_id"
  add_foreign_key "bm_purchase_items", "bm_purchases", column: "purchase_id"
  add_foreign_key "bm_purchases", "bm_users", column: "created_by"
  add_foreign_key "bm_sale_items", "bm_items", column: "item_id"
  add_foreign_key "bm_sale_items", "bm_sales", column: "sale_id"
  add_foreign_key "bm_sales", "bm_users", column: "created_by"
  add_foreign_key "bm_stock_entries", "bm_items", column: "item_id"
  add_foreign_key "bm_stock_entries", "bm_users", column: "created_by"
end

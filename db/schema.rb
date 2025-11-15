# frozen_string_literal: true

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

ActiveRecord::Schema[7.1].define(version: 20_250_508_172_203) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'pgcrypto'
  enable_extension 'plpgsql'

  # Custom types defined in this database.
  # Note that some types may not work with other database engines. Be careful if changing database.
  create_enum 'adjustment_type_enum', %w[add remove]
  create_enum 'stock_entry_type', %w[purchase adjustment return]

  create_table 'adjustments', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.uuid 'item_id', null: false
    t.enum 'adjustment_type', null: false, enum_type: 'adjustment_type_enum'
    t.integer 'quantity'
    t.text 'reason'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'items', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.string 'name'
    t.string 'sku', null: false
    t.text 'description'
    t.decimal 'unit_price', precision: 10, scale: 2
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['sku'], name: 'index_items_on_sku', unique: true
  end

  create_table 'purchase_items', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.uuid 'purchase_id', null: false
    t.uuid 'item_id', null: false
    t.integer 'quantity'
    t.decimal 'unit_price', precision: 10, scale: 2
    t.decimal 'total_price', precision: 12, scale: 2
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'purchases', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.string 'supplier_name'
    t.string 'invoice_number', null: false
    t.date 'date'
    t.decimal 'total_amount', precision: 12, scale: 2
    t.uuid 'created_by'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['invoice_number'], name: 'index_purchases_on_invoice_number', unique: true
  end

  create_table 'sale_items', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.uuid 'sale_id', null: false
    t.uuid 'item_id', null: false
    t.integer 'quantity'
    t.decimal 'unit_price', precision: 10, scale: 2
    t.decimal 'total_price', precision: 12, scale: 2
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'sales', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.string 'customer_name'
    t.string 'invoice_number', null: false
    t.date 'date'
    t.decimal 'total_amount', precision: 12, scale: 2
    t.uuid 'created_by'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['invoice_number'], name: 'index_sales_on_invoice_number', unique: true
  end

  create_table 'stock_entries', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.uuid 'item_id', null: false
    t.integer 'quantity', null: false
    t.enum 'entry_type', null: false, enum_type: 'stock_entry_type'
    t.string 'source'
    t.text 'notes'
    t.uuid 'created_by', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'users', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.string 'name'
    t.string 'email', null: false
    t.string 'password_digest'
    t.string 'role'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['email'], name: 'index_users_on_email', unique: true
  end

  add_foreign_key 'adjustments', 'items'
  add_foreign_key 'purchase_items', 'items'
  add_foreign_key 'purchase_items', 'purchases'
  add_foreign_key 'purchases', 'users', column: 'created_by'
  add_foreign_key 'sale_items', 'items'
  add_foreign_key 'sale_items', 'sales'
  add_foreign_key 'sales', 'users', column: 'created_by'
  add_foreign_key 'stock_entries', 'items'
  add_foreign_key 'stock_entries', 'users', column: 'created_by'
end

class CreateBusinessManagementTables < ActiveRecord::Migration[8.1]
  def change
    enable_extension "pgcrypto"
    enable_extension "plpgsql"

    create_enum "bm_adjustment_type_enum", ["add", "remove"]
    create_enum "bm_stock_entry_type", ["purchase", "adjustment", "return"]

    create_table "bm_users", id: :uuid, default: -> { "gen_random_uuid()" } do |t|
      t.string "name"
      t.string "email", null: false
      t.string "password_digest"
      t.string "role"
      t.timestamps
      t.index ["email"], name: "index_bm_users_on_email", unique: true
    end

    create_table "bm_items", id: :uuid, default: -> { "gen_random_uuid()" } do |t|
      t.string "name"
      t.string "sku", null: false
      t.text "description"
      t.decimal "unit_price", precision: 10, scale: 2
      t.timestamps
      t.index ["sku"], name: "index_bm_items_on_sku", unique: true
    end

    create_table "bm_purchases", id: :uuid, default: -> { "gen_random_uuid()" } do |t|
      t.string "supplier_name"
      t.string "invoice_number", null: false
      t.date "date"
      t.decimal "total_amount", precision: 12, scale: 2
      t.uuid "created_by"
      t.timestamps
      t.index ["invoice_number"], name: "index_bm_purchases_on_invoice_number", unique: true
      t.foreign_key "bm_users", column: "created_by"
    end

    create_table "bm_purchase_items", id: :uuid, default: -> { "gen_random_uuid()" } do |t|
      t.uuid "purchase_id", null: false
      t.uuid "item_id", null: false
      t.integer "quantity"
      t.decimal "unit_price", precision: 10, scale: 2
      t.decimal "total_price", precision: 12, scale: 2
      t.timestamps
      t.foreign_key "bm_purchases", column: "purchase_id"
      t.foreign_key "bm_items", column: "item_id"
    end

    create_table "bm_sales", id: :uuid, default: -> { "gen_random_uuid()" } do |t|
      t.string "customer_name"
      t.string "invoice_number", null: false
      t.date "date"
      t.decimal "total_amount", precision: 12, scale: 2
      t.uuid "created_by"
      t.timestamps
      t.index ["invoice_number"], name: "index_bm_sales_on_invoice_number", unique: true
      t.foreign_key "bm_users", column: "created_by"
    end

    create_table "bm_sale_items", id: :uuid, default: -> { "gen_random_uuid()" } do |t|
      t.uuid "sale_id", null: false
      t.uuid "item_id", null: false
      t.integer "quantity"
      t.decimal "unit_price", precision: 10, scale: 2
      t.decimal "total_price", precision: 12, scale: 2
      t.timestamps
      t.foreign_key "bm_sales", column: "sale_id"
      t.foreign_key "bm_items", column: "item_id"
    end

    create_table "bm_adjustments", id: :uuid, default: -> { "gen_random_uuid()" } do |t|
      t.uuid "item_id", null: false
      t.enum "adjustment_type", enum_type: "bm_adjustment_type_enum", null: false
      t.integer "quantity"
      t.text "reason"
      t.timestamps
      t.foreign_key "bm_items", column: "item_id"
    end

    create_table "bm_stock_entries", id: :uuid, default: -> { "gen_random_uuid()" } do |t|
      t.uuid "item_id", null: false
      t.integer "quantity", null: false
      t.enum "entry_type", enum_type: "bm_stock_entry_type", null: false
      t.string "source"
      t.text "notes"
      t.uuid "created_by", null: false
      t.timestamps
      t.foreign_key "bm_items", column: "item_id"
      t.foreign_key "bm_users", column: "created_by"
    end
  end
end
# db/migrate/20251115232243_drop_old_non_prefixed_tables.rb
class DropOldNonPrefixedTables < ActiveRecord::Migration[8.1]
  def change
    # Use CASCADE to automatically drop dependent objects
    drop_table :adjustments, if_exists: true, force: :cascade
    drop_table :purchase_items, if_exists: true, force: :cascade
    drop_table :sale_items, if_exists: true, force: :cascade
    drop_table :stock_entries, if_exists: true, force: :cascade
    drop_table :purchases, if_exists: true, force: :cascade
    drop_table :sales, if_exists: true, force: :cascade
    drop_table :items, if_exists: true, force: :cascade
    drop_table :users, if_exists: true, force: :cascade
  end
end
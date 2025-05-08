class CreateStockEntries < ActiveRecord::Migration[7.1]
  def change
    create_table :stock_entries, id: :uuid do |t|
      t.uuid :item_id, null: false
      t.integer :quantity, null: false
      t.column :entry_type, :stock_entry_type, null: false
      t.string :source
      t.text :notes
      t.uuid :created_by, null: false

      t.timestamps
    end

    add_foreign_key :stock_entries, :items
    add_foreign_key :stock_entries, :users, column: :created_by
  end
end

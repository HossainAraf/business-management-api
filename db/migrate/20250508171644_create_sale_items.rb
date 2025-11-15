# frozen_string_literal: true

class CreateSaleItems < ActiveRecord::Migration[7.1]
  def change
    create_table :sale_items, id: :uuid do |t|
      t.uuid :sale_id, null: false
      t.uuid :item_id, null: false
      t.integer :quantity
      t.decimal :unit_price, precision: 10, scale: 2
      t.decimal :total_price, precision: 12, scale: 2

      t.timestamps
    end

    add_foreign_key :sale_items, :sales
    add_foreign_key :sale_items, :items
  end
end

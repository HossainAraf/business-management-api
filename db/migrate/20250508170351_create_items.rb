# frozen_string_literal: true

class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_table :items, id: :uuid do |t|
      t.string :name
      t.string :sku, null: false, index: { unique: true }
      t.text :description
      t.decimal :unit_price, precision: 10, scale: 2

      t.timestamps
    end
  end
end

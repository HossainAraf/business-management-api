# frozen_string_literal: true

class CreateAdjustments < ActiveRecord::Migration[7.1]
  def change
    create_table :adjustments, id: :uuid do |t|
      t.uuid :item_id, null: false
      t.column :adjustment_type, :adjustment_type_enum, null: false
      t.integer :quantity
      t.text :reason

      t.timestamps
    end

    add_foreign_key :adjustments, :items
  end
end

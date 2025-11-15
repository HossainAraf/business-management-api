# frozen_string_literal: true

class CreateSales < ActiveRecord::Migration[7.1]
  def change
    create_table :sales, id: :uuid do |t|
      t.string :customer_name
      t.string :invoice_number, null: false, index: { unique: true }
      t.date :date
      t.decimal :total_amount, precision: 12, scale: 2
      t.uuid :created_by

      t.timestamps
    end

    add_foreign_key :sales, :users, column: :created_by
  end
end

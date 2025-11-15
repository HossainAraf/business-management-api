# frozen_string_literal: true

class Item < ApplicationRecord
  has_many :purchase_items
  has_many :purchases, through: :purchase_items
  has_many :sale_items
  has_many :sales, through: :sale_items
  has_many :adjustments
  has_many :stock_entries

  validates :sku, presence: true, uniqueness: true
end

# frozen_string_literal: true

class SaleItem < ApplicationRecord
  belongs_to :sale
  belongs_to :item

  validates :quantity, :unit_price, :total_price, presence: true
end

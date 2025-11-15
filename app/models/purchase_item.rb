# frozen_string_literal: true

class PurchaseItem < ApplicationRecord
  belongs_to :purchase
  belongs_to :item

  validates :quantity, :unit_price, :total_price, presence: true
end

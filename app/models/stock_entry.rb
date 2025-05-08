class StockEntry < ApplicationRecord
  belongs_to :item
  belongs_to :creator, class_name: "User", foreign_key: :created_by

  enum entry_type: {
    purchase: "purchase",
    adjustment: "adjustment",
    return: "return"
  }

  validates :entry_type, :quantity, presence: true
end

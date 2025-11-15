class Purchase < ApplicationRecord
  has_many :purchase_items, dependent: :destroy
  has_many :items, through: :purchase_items
  belongs_to :creator, class_name: 'User', foreign_key: :created_by

  validates :invoice_number, presence: true, uniqueness: true
end

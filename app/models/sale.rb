# frozen_string_literal: true

class Sale < ApplicationRecord
  has_many :sale_items, dependent: :destroy
  has_many :items, through: :sale_items
  belongs_to :creator, class_name: 'User', foreign_key: :created_by

  validates :invoice_number, presence: true, uniqueness: true
end

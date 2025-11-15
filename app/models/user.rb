class User < ApplicationRecord
  has_secure_password

  has_many :purchases, foreign_key: :created_by
  has_many :sales, foreign_key: :created_by
  has_many :stock_entries, foreign_key: :created_by

  validates :email, presence: true, uniqueness: true
end

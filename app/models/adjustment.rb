class Adjustment < ApplicationRecord
  belongs_to :item

  enum adjustment_type: {
    add: 'add',
    remove: 'remove'
  }

  validates :adjustment_type, :quantity, presence: true
end

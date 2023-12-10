class OrderedProduct < ApplicationRecord
  belongs_to :order
  belongs_to :product

  validates :quantity, is_numeric: true
end

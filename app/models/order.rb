class Order < ApplicationRecord
  belongs_to :user
  has_many :ordered_products

  validates :order_date, date
end

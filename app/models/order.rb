class Order < ApplicationRecord
  belongs_to :user
  has_many :ordered_products

  validates :order_date, on_or_before: -> { Date.current }, type: :date
end

class Product < ApplicationRecord
  validates :product_name, uniqueness: true, presence: true
  belongs_to :category, class_name: "Category"
  has_one_attached :image
end

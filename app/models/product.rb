class Product < ApplicationRecord
  belongs_to :category, class_name: "Category"
  has_one_attached :image
end

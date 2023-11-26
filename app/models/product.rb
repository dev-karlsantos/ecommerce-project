class Product < ApplicationRecord
  belongs_to :categories, class_name: "Category"
  has_one_attached :image_file
end

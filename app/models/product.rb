class Product < ApplicationRecord
  belongs_to :categories, class_name: "Category"
end

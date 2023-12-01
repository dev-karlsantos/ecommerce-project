json.extract! product, :id, :categories_id, :product_name, :price, :description, :stock_quantity,
              :image, :created_at, :updated_at
json.url product_url(product, format: :json)

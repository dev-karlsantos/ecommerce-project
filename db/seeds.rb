# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require "csv"

Product.delete_all
Category.delete_all

ActiveRecord::Base.connection.execute("DELETE FROM sqlite_sequence WHERE name='products';")
ActiveRecord::Base.connection.execute("DELETE FROM sqlite_sequence WHERE name='categories';")

categories_filename = Rails.root.join("db/Categories.csv")
products_filename = Rails.root.join("db/Products.csv")

puts "Loading CSV..."

categories_csv_data = File.read(categories_filename)
products_csv_data = File.read(products_filename)

categories_data = CSV.parse(categories_csv_data, headers: true, encoding: "utf-8")
products_data = CSV.parse(products_csv_data, headers: true, encoding: "utf-8")

categories_data.each do |c|
  categories = Category.new(category_name: c)

  categories.save
  puts "Category not saved" unless categories&.valid?
  puts "#{c}" # weird
end
# puts "#{categories_data}"
puts "Created #{Category.count} categories."

products_data.each do |p|
  id = p["category_id"].to_i + 1
  category = Category.find(id)
  products = Product.new(product_name: p["product_name"], price: p["price"],
                         description: p["description"], stock_quantity: p["stock_quantity"], image_file: p["image"])
  products.categories = category
  # puts "#{p['product_name']}"
  products.save
  puts "Product not saved" unless products&.valid?
  puts p["product_name"]
end

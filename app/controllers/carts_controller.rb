class CartsController < ApplicationController
  before_action :authenticate_user!, only: %i[show add_to_cart remove_from_cart]

  def show
    @cart_items = session[:cart] || {}  # Assuming cart information is stored in the session

    # You may want to retrieve additional information about the products in the cart
    @products_in_cart = Product.where(id: @cart_items.keys)

    # Optionally, you can calculate the total price of items in the cart
    @total_price = calculate_total_price(@cart_items)
    render "show"
  end

  def add_to_cart
    product = find_product
    puts "Before Cart: #{session[:cart]}"
    update_cart(product, 1)
    puts "After Cart: #{session[:cart]}"
    redirect_to_cart
  end

  def remove_from_cart
    product = find_product
    puts "Before Cart: #{session[:cart]}"
    update_cart(product, -1)
    puts "After Cart: #{session[:cart]}"
    redirect_to_cart
  end

  private

  def calculate_total_price(cart_items)
    total_price = 0

    cart_items.each do |_product_id, item|
      total_price += item["quantity"].to_i * item["price"].to_f
    end

    total_price
  end

  def find_product
    Product.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to products_path, alert: "Product not found."
  end

  def update_cart(product, quantity_change)
    session[:cart] ||= {}
    product_id = product.id.to_s # Convert product ID to string
    session[:cart][product_id] ||= { "name" => product.product_name, "price" => product.price,
"quantity" => 0 }

    # Ensure quantity is initialized before updating
    current_quantity = session[:cart][product_id]["quantity"].to_i
    new_quantity = [current_quantity + quantity_change, 0].max

    session[:cart][product_id]["quantity"] = new_quantity
    session[:cart].delete(product_id) if new_quantity.zero?
  end

  def redirect_to_cart
    redirect_to cart_path, notice: "Cart updated."
  end
end

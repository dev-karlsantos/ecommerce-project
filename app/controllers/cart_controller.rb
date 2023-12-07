class CartsController < ApplicationController
  before_action :authenticate_user!, only: %i[add_to_cart remove_from_cart]

  def add_to_cart
    unless user_signed_in?
      puts "User not signed in. Redirecting to login."
      redirect_to new_user_session_path
    end
    product = find_product
    update_cart(product, 1)
    redirect_to_cart
  end

  def remove_from_cart
    product = find_product
    update_cart(product, -1)
    redirect_to_cart
  end

  private

  def find_product
    Product.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to products_path, alert: "Product not found."
  end

  def update_cart(product, quantity_change)
    session[:cart] ||= {}
    session[:cart][product.id] ||= { name: product.name, price: product.price, quantity: 0 }
    session[:cart][product.id][:quantity] += quantity_change
    session[:cart].delete(product.id) if session[:cart][product.id][:quantity] <= 0
  end

  def redirect_to_cart
    redirect_to cart_path, notice: "Cart updated."
  end
end

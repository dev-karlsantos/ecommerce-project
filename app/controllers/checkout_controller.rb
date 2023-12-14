class CheckoutController < ApplicationController
  def create
    # Get items from the session
    cart_items = session[:cart]

    # Save address information to the user model
    province_id = params[:province].to_i
    @province = Province.find_by(id: province_id)
    user = current_user
    if params[:save_address] == "1"
      user.update(
        address:     params[:street_address],
        postal_code: params[:postal_code],
        city:        params[:city],
        country:     params[:country],
        province:    @province
      )
    end

    if cart_items.nil?
      puts "Cart is empty."
      redirect_to root_path
      return
    end

    # Create a Stripe checkout session
    checkout_session = Stripe::Checkout::Session.create(
      # client_reference_id:  current_user.id,
      payment_method_types: ["card"],
      line_items:           build_line_items(cart_items, @province),
      mode:                 "payment",
      success_url:          checkout_success_url + "?session_id={CHECKOUT_SESSION_ID}",
      cancel_url:           checkout_cancel_url
    )
    redirect_to checkout_session.url, allow_other_host: true
  end

  def success
    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent)
    session.delete(:cart)
    redirect_to root_path
  end

  def cancel
    # Cancellation of transaction
    redirect_to cart_path(current_user), notice: "Transaction cancelled."
  end

  private

  def build_line_items(cart_items, province)
    line_items = []
    cart_items.each do |_product_id, item|
      line_items << {
        price_data: {
          currency:     "cad",
          product_data: {
            name: item["name"]
          },
          unit_amount:  (item["price"].to_i * 100)
        },
        quantity:   item["quantity"]
      }

      line_items << {
        price_data: {
          currency:     "cad",
          product_data: {
            name: "GST"
          },
          unit_amount:  (province.gst * 100).round * item["price"].to_i
        },
        quantity:   1
      }
    end
    line_items
  end

  def create_tax_line_items(user_province)
    @province = Province.find_by(id: user_province)

    unless @province
      puts "Error: Province not found for #{user_province}"
      return {}
    end

    tax_line_items = {}

    new_items = {
      price_data: {
        currency:     "cad",
        product_data: {
          name: "GST"
        },
        unit_amount:  @province.gst.to_i * 100
      },
      quantity:   1
    }

    tax_line_items.merge!(new_items)
  end
end

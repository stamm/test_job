class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  private

  def current_cart
    @current_cart ||= find_or_create_cart
  end

  def find_or_create_cart
    #Cart.includes(line_items: :product).find session[:cart_id]
    Cart.find session[:cart_id]
  rescue ActiveRecord::RecordNotFound
    cart = Cart.create user: current_user
    session[:cart_id] = cart.id
    cart
  end

  helper_method :current_cart
end

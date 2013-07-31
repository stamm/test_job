class StoreController < AuthController
  def index
    @products = Product.order(:id)
    @current_cart = current_cart
    @cart_total_price = @current_cart.total_price
  end
end

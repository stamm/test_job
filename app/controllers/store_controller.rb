class StoreController < AuthController
  def index
    @products = Product.order(:id)
  end
end

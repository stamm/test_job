require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe OrdersController do

  login_user

  describe "GET #new" do
    it 'require items in cart' do
      get :create
      expect(response).to redirect_to(root_path)
    end
    it 'create order' do
      product = create :product
      item = LineItem.new
      item.build_cart
      item.product = product
      item.save!
      session[:cart_id] = item.cart.id

      @current_user.add_balance(product.price + 1)
      expect {
        get :create
      }.to change(Order, :count).by(1)

      expect(response).to redirect_to(root_path)
    end
  end

end

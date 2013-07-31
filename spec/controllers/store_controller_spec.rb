require 'spec_helper'

describe StoreController do

  describe 'needing login' do
    describe 'GET index' do
      it 'redirect' do
        get :index
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "GET 'index'" do
    login_user
    it "returns http success" do
      get 'index'
      expect(response).to be_success
    end
    it 'has a products' do
      product = create :product
      get :index
      expect(assigns(:products)).to include product
    end
  end

end

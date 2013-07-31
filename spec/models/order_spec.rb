require 'spec_helper'

describe Order do
  before(:each) do
    @cart = Cart.create
    @product = create :product
    @line_item = @cart.add_product(@product.id)
    @cart.save!
    @user = create :user, balance: @cart.total_price
    subject.user = @user
  end

  describe '#save' do
    it 'check line_items is empty' do
      expect(subject.valid?).to be_false
      #expect{ subject.save_with_transaction }.to raise_error(RuntimeError, 'Your cart empty')
    end

    it 'check user balance' do
      subject.add_line_items_from_cart(@cart)
      @user.update_attribute(:balance, 0)
      expect(subject.valid?).to be_false
      #expect{ subject.save_with_transaction }.to raise_error(RuntimeError, 'Need more gold!')
    end

    it 'saved' do
      subject.add_line_items_from_cart(@cart)
      expect{ subject.save_with_transaction }.to be_true
    end

  end

  describe '#add_line_items_from_cart' do


    it '#add_line_items_from_cart' do
      subject.add_line_items_from_cart(@cart)
      expect(subject.line_items.first.cart_id).to be_nil
      subject.save
      expect(subject.line_items.first.order_id).to eq(subject.id)
    end
  end
end

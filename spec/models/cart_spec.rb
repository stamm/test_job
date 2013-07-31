require 'spec_helper'

describe Cart do
  describe '#add_product' do
    it 'add new product' do
      product = create :product
      subject.save!
      line_item = subject.add_product(product.id)
      expect(line_item).to be_a(LineItem)
      expect(line_item.product_id).to eq(product.id)
      expect(line_item.cart_id).to eq(subject.id)
      expect(line_item.quantity).to eq(1)
      #product_ids = subject.line_items.map{ |i| i.product_id }
      #expect(product_ids).to be_include(product.id)
    end

    it 'add duplicate product' do
      product = create :product
      subject.save
      line_item = subject.add_product(product.id)
      line_item.save!
      expect(line_item.quantity).to eq(1)
      #expect { subject.add_product(product.id).save! }.to change { line_item.quantity }.from(1).to(2)
      line_item = subject.add_product(product.id)
      expect(line_item.quantity).to eq(2)
    end
  end
end

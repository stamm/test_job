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

  it '#total_price' do
    product1 = create :product, price: 3
    product2 = create :product, price: 7
    subject.save!
    line_item1 = subject.add_product(product1.id)
    line_item1.save
    line_item2 = subject.add_product(product2.id)
    line_item2.save
    expect { line_item1.update_attribute :quantity, 2 }.to change { subject.total_price }.from(10).to(13)
    #expect(subject.total_price).to eq(10)
    #line_item1.update_attribute :quantity, 2
    #expect(subject.total_price).to eq(13)
  end
end

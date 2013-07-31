require 'spec_helper'

describe LineItem do
  it '#total_price' do
    product = create(:product, price: 4)
    line_item = product.line_items.create
    expect { line_item.quantity = 2 }.to change { line_item.total_price }.from(4).to(8)
    #expect(line_item.total_price).to eq(4)
    #line_item.quantity = 2
    #expect(line_item.total_price).to eq(8)
  end
end

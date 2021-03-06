class Cart < ActiveRecord::Base
  belongs_to :user
  has_many :line_items, dependent: :destroy

  accepts_nested_attributes_for :line_items

  include TotalPrice

  def add_product(product_id)
    current_item = line_items.find_by(product_id: product_id)
    if current_item
      current_item.quantity += 1
    else
      current_item = line_items.build(product_id: product_id)
    end
    current_item
  end
end

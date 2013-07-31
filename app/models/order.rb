class Order < ActiveRecord::Base
  include TotalPrice

  has_many :line_items, dependent: :destroy
  belongs_to :user

  validate :validate_line_items, :validate_user_balance


  scope :all_include, -> { includes(:user, line_items: :product) }
  scope :order_by_create, -> { order(created_at: :desc) }


  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end

  def save_with_transaction
    if valid?
      User.transaction do
        fail 'Your cart empty' if line_items_empty?
        fail 'Need more gold!' unless enough_user_balance?
        user.increment!(:balance, - total_price)
        save!
      end
    end
  end

  private

  def validate_line_items
    if line_items_empty?
      errors.add(:line_items, 'Line items cant be empty')
    end
  end

  def validate_user_balance
    unless enough_user_balance?
      errors.add(:user, 'Not enough user money')
    end
  end

  def line_items_empty?
    line_items.empty?
  end

  def enough_user_balance?
    if user
      total_price < user.reload.balance
    else
      false
    end
  end
end

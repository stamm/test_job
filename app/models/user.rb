class User < ActiveRecord::Base

  has_many :orders

  # Include default devise modules. Others available are:
  # :token_authenticatable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  def add_balance(sum)
    self.increment!(:balance, sum)
  end
end

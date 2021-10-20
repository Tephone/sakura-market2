class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :cart_products, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :diaries, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :user_coupons, dependent: :destroy
  has_many :coupons, through: :user_coupons, source: :coupon
  validates :name, presence: true

  def available_coupon_point
    self.coupons.sum(:point) - self.orders.sum(:coupon_point)
  end
end

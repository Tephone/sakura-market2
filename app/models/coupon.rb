class Coupon < ApplicationRecord
  has_many :user_coupons, dependent: :destroy
  has_many :users, through: :user_coupons, source: :user
  validates :code, presence: true, length: { is: 12 }
  validates :point, presence: true, numericality: { only_integer: true, greater_tha_or_equal_to: 1 }
end

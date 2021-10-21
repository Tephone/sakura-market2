class UserCoupon < ApplicationRecord
  before_validation :find_coupon_by_code

  belongs_to :user
  belongs_to :coupon
  attribute :code, :string
  validates :coupon_id, uniqueness: {scope: :user_id}
  validates :code, presence: true

  private

  def find_coupon_by_code
    self.coupon = Coupon.find_by(code: self.code)
    # アソシエーションでuser_coupon.couponとかける、user_coupon.couponにc値が入ることは、user_couponのcoupon_idに値が入ることと同義
    # self.couponがnilの場合はb「longs_to :coupon」のvalidationに引っかかる(アソシエーションはdefaultでpresence:trueになる)
  end
end

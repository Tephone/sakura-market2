class Order < ApplicationRecord
  belongs_to :user
  belongs_to :seller
  belongs_to :delivery_time
  has_many :ordered_products, dependent: :destroy
  attribute :cart_products
  validate :invalid_holiday
  validate :validate_weekdays, on: :create
  validate :seller_validate, on: :create
  validates :delivery_date, presence: true
  validates :coupon_point, presence: true,
                           numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: ->(order) {
                                                                                                                     order.user.available_coupon_point
                                                                                                                   } }
  enum status: %i[ordered ready_to_ship shipped cancel]
  scope :delivery_date_order, -> { order(:delivery_date) }

  class << self
    def min_delivery_date
      Date.current + 3
    end

    def max_delivery_date
      max_delivery_date = Date.current + 14
      dates = (min_delivery_date..max_delivery_date)
      additional_days = dates.count { |date| date.saturday? || date.sunday? }
      max_delivery_date + additional_days
    end
  end

  def create_with(cart_products)
    self.send_fee = CartProduct.send_fee(cart_products)
    self.cod_charge = CartProduct.cod_charge(cart_products)
    self.seller_id = CartProduct.seller(cart_products).id
    self.cart_products = cart_products
    ApplicationRecord.transaction do
      self.save!
      cart_products.each do |cart_product|
        OrderedProduct.create!(order_id: self.id, product_id: cart_product.product.id, price: cart_product.product.price, amount: cart_product.amount)
      end
      cart_products.each(&:destroy!)
    end
  end

  def cancel(order)
    order.status = 'cancel'
    order.save!
  end

  private

  def invalid_holiday
    if self.delivery_date.saturday? || self.delivery_date.sunday?
      errors.add(:delivery_date, 'は平日(月-金)を指定してください')
    end
  end

  def validate_weekdays
    dates = Order.min_delivery_date..Order.max_delivery_date.to_date
    unless dates.include?(self.delivery_date)
      errors.add(:delivery_date, 'は3営業日（営業日: 月-金）から14営業日までの期間で選択してください')
    end
  end

  def seller_validate
    unless self.cart_products.distinct.count == 1
      errors.add(:cart_products, 'に複数業者の商品入っています')
    end
  end
end

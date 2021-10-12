class Order < ApplicationRecord
  belongs_to :user
  belongs_to :seller
  belongs_to :delivery_time
  has_many :ordered_products, dependent: :destroy
  validate :invalid_holiday
  validate :should_be_after_3_to_14_weekdays
  validates :delivery_date, presence: true

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
    ApplicationRecord.transaction do
      self.save!
      cart_products.each do |cart_product|
        OrderedProduct.create!(order_id: self.id, product_id: cart_product.product.id, price: cart_product.product.price, amount: cart_product.amount)
      end
      cart_products.each(&:destroy!)
    end
  end

  private

  def invalid_holiday
    if self.delivery_date.saturday? || self.delivery_date.sunday?
      errors.add(:delivery_date, 'は平日(月-金)を指定してください')
    end
  end

  def should_be_after_3_to_14_weekdays
    dates = Order.min_delivery_date..Order.max_delivery_date.to_date
    unless dates.include?(self.delivery_date)
      errors.add(:delivery_sate, 'は3営業日（営業日: 月-金）から14営業日までの期間で選択してください')
    end
  end
end

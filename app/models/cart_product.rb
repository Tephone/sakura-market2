class CartProduct < ApplicationRecord
  belongs_to :user
  belongs_to :product
  validates :amount, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: ->(cart_product) {
                                                                                                                               cart_product.product.stock
                                                                                                                             } }

  class << self
    def seller(cart_products)
      cart_products.first.product.seller # cart_productsに含まれている値を一つ取り出したかったため、firstを使用しています
    end

    def total_price(cart_products)
      cart_products.sum { |cart_product| cart_product.product.price * cart_product.amount }
    end

    def send_fee(cart_products)
      seller = seller(cart_products)
      seller.send_fee_per_box * (cart_products.count.to_f / seller.capacity_per_box).ceil
    end

    def cod_charge(cart_products)
      total_price = total_price(cart_products)
      if (0..9999).include?(total_price)
        300
      elsif (10000..29999).include?(total_price)
        400
      elsif (30000..99999).include?(total_price)
        600
      elsif 100000 <= total_price
        1000
      end
    end

    def same_seller?(cart_products)
      products = Product.where(id: cart_products.select(:product_id))
      products.select(:seller_id).distinct.count == 1
    end
  end

  def create_with(product_id)
    self.product_id = product_id
    ApplicationRecord.transaction do
      self.save!
      self.product.update!(stock: self.product.stock - self.amount)
      # NOTE: カートに追加した分、商品の在庫数を減らす処理
    end
  end

  def destroy_and_update_product_stock
    ApplicationRecord.transaction do
      self.product.update!(stock: self.product.stock + self.amount)
      self.destroy!
      # カートから外した分、商品の在庫数を増やす処理
    end
  end
end

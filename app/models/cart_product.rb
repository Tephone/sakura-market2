class CartProduct < ApplicationRecord
  belongs_to :user
  belongs_to :product

  class << self
    def total_price(cart_products)
      cart_products.sum {|cart_product| cart_product.product.price * cart_product.amount}
    end

    def send_fee(cart_products)
      seller = cart_products.first.product.seller #cart_productsに含まれている値を一つ取り出したかったため、firstを使用しています
      seller.send_fee_per_box * (cart_products.count.to_f / seller.capacity_per_box).ceil
    end

    def cod_charge(cart_products)
      total_price = total_price(cart_products)
      if (0..9999) === total_price
        300
      elsif (10000..29999) === total_price
        400
      elsif (30000..99999) === total_price
        600
      elsif 100000 <= total_price
        1000
      end
    end
  end
end

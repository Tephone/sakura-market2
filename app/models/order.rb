class Order < ApplicationRecord
  belongs_to :user
  belongs_to :seller
  belongs_to :delivery_time
  has_many :ordered_products, dependent: :destroy

  class << self
    def create_order_and_ordered_product(order, cart_products)
      order.send_fee = CartProduct.send_fee(cart_products)
      order.cod_charge = CartProduct.cod_charge(cart_products)
      order.seller_id = cart_products.first.product.seller_id #cart_productsに含まれている値を一つ取り出したかったため、firstを使用しています
      ApplicationRecord.transaction do
        order.save!
        cart_products.each do |cart_product|
          OrderedProduct.create!(order_id: order.id, product_id: cart_product.product.id, price: cart_product.product.price, amount: cart_product.amount)
        end
        cart_products.each(&:destroy!)
      end
    end
  end
end

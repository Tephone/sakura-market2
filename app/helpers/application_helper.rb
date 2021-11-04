module ApplicationHelper
  def sellers_option
    Seller.order(id: :desc).pluck(:name, :id)
  end

  def delivery_times_option
    DeliveryTime.order(id: :desc).map { |delivery_time| ["#{delivery_time.start_time}時-#{delivery_time.end_time}時", delivery_time.id] }
  end

  def currency(price)
    number_to_currency(price, unit: '円')
  end

  def detail_of_order_total_price(cart_products)
    total_price = (CartProduct.total_price(cart_products) + CartProduct.send_fee(cart_products) + CartProduct.cod_charge(cart_products))
    '合計: ' + currency((total_price * 1.1).to_i) + "(商品代金: #{currency(CartProduct.total_price(cart_products))}送料: #{currency(CartProduct.send_fee(cart_products))} 代引き手数料: #{currency(CartProduct.cod_charge(cart_products))} + 消費税）"
  end

  def i18n_status(status)
    t("status.#{status}")
  end

  def order_status_option
    Order.statuses.map { |k, _v| [i18n_status(k), k] }
  end
end

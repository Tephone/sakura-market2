module ApplicationHelper
  def sellers_option
    Seller.order(id: :desc).pluck(:name, :id)
  end

  def currency(price)
    number_to_currency(price, unit: '円')
  end
end

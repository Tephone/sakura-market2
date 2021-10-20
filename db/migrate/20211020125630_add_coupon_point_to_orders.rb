class AddCouponPointToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :coupon_point, :integer, null: false, default: 0
  end
end

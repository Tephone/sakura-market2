class Users::OrderCancelsController < Users::ApplicationController
  def update
    order = current_user.orders.find(params[:id])
    order.cancel(order)
    redirect_to users_order_path(order), notice: '注文をキャンセルしました'
  end
end

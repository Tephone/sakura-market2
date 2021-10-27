class Users::OrderCancelsController < Users::ApplicationController
  def update
    order = current_user.orders.find(params[:id])
    order.status = 'cancel'
    order.save!
    redirect_to users_order_path(order), notice: '注文をキャンセルしました'
  end
end

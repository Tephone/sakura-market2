class Sellers::OrdersController < Sellers::ApplicationController
  before_action :set_order, only: %i[show edit update]

  def index
    @orders = current_seller.orders.delivery_date_asc.page(params[:page])
  end

  def show
  end

  def edit
  end

  def update    
    if @order.update(order_params)
      redirect_to sellers_order_path(@order), notice: 'ステータスを更新しました'
    else
      render :edit
    end
  end

  private

  def set_order
    @order = current_seller.orders.find(params[:id])
  end
  
  def order_params
    params.require(:order).permit(:status)
  end
end

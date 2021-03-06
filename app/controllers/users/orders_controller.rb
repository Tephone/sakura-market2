class Users::OrdersController < Users::ApplicationController
  def index
    @orders = current_user.orders.default_order.page(params[:page])
  end

  def new
    @cart_products = current_user.cart_products.where(id: params[:cart_product_ids])
    @order = current_user.orders.new
    unless CartProduct.same_seller?(@cart_products)
      redirect_to users_cart_products_path, alert: '複数業者の商品入っています'
    end
  end

  def create
    @cart_products = current_user.cart_products.where(id: params[:order][:cart_product_ids])
    @order = current_user.orders.new(order_params)
    if @order.create_with(@cart_products)
      redirect_to users_cart_products_path, notice: '商品を購入しました'
    else
      render :new
    end
  end

  def show
    @order = current_user.orders.find(params[:id])
  end

  private

  def order_params
    params.require(:order).permit %i[cart_product_ids delivery_date delivery_time_id coupon_point]
  end
end

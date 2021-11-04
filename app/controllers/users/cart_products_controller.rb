class Users::CartProductsController < Users::ApplicationController
  def index
    @cart_products = current_user.cart_products.default_order.page(params[:page])
  end

  def destroy
    @cart_product = current_user.cart_products.find(params[:id])
    @cart_product.destroy_and_update_product_stock
    redirect_to users_cart_products_path, notice: '商品をカートから外しました'
  end
end

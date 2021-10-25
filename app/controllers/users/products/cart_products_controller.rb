class Users::Products::CartProductsController < Users::ApplicationController
  def new
    @cart_product = current_user.cart_products.new
  end

  def create
    @cart_product = current_user.cart_products.new(cart_product_params)
    if @cart_product.create_with(params[:product_id])
      redirect_to users_cart_products_path, notice: 'カートに追加しました'
    else
      render :new
    end
  end

  private

  def cart_product_params
    params.require(:cart_product).permit(:amount)
  end
end

class Users::Products::CartProductsController < Users::ApplicationController
  def new
    @cart_product = current_user.cart_products.new
  end

  def create
    @cart_product = current_user.cart_products.new(cart_product_params)
    @cart_product.product_id = params[:product_id]
    if @cart_product.save
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

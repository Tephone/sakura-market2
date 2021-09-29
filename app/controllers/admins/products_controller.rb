class Admins::ProductsController < Admins::ApplicationController
  before_action :set_product, only: %i[show edit update destroy]

  def index
    @products = Product.default_order.page(params[:page])
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params_to_create)
    if @product.save
      redirect_to admins_products_path, notice: '商品を登録しました'
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @product.update(product_params_to_update)
      redirect_to admins_product_path(@product), notice: '商品情報を更新しました'
    else
      render :edit
    end
  end

  def destroy
    @product.destroy!
    redirect_to admins_products_path, notice: '商品を削除しました'
  end

  private

  def product_params_to_create
    params.require(:product).permit %i[name price seller_id]
  end

  def product_params_to_update
    params.require(:product).permit %i[name price seller_id image content display]
  end

  def set_product
    @product = Product.find(params[:id])
  end
end

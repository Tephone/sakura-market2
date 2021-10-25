class Sellers::ProductsController < ApplicationController
  before_action :set_product, only: %i[show edit update]

  def index
    @products = current_seller.products.default_order.page(params[:page])
  end
  
  def new
    @product = current_seller.products.new
  end

  def create
    @product = current_seller.products.new(create_product_params)
    if @product.save
      redirect_to sellers_products_path, notice: '商品を登録しました'
    else
      render :new
    end
  end

  def show
  end

  def edit
  end
  
  def update
    @product.stock = @product.total_stock(params[:product][:stock])
    if @product.update(update_product_params)
      redirect_to sellers_product_path(@product), notice: '商品情報を更新しました'
    else
      render :new
    end
  end

  private

  def create_product_params
    params.require(:product).permit %i[name price]
  end

  def update_product_params
    params.require(:product).permit %i[name price content image]
  end

  def set_product
    @product = current_seller.products.find(params[:id])
  end
end

class Users::ProductsController < Users::ApplicationController
  def index
    @products = Product.default_order.page(params[:page])
  end

  def show
    @product = Product.find(params[:id])
  end
end

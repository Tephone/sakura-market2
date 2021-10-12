class Admins::SellersController < Admins::ApplicationController
  def index
    @sellers = Seller.default_order.page(params[:page])
  end

  def new
    @seller = Seller.new
  end

  def create
    @seller = Seller.new(seller_params)
    if @seller.save
      redirect_to admins_sellers_path, notice: '業者を作成しました'
    else
      render :new
    end
  end

  private

  def seller_params
    params.require(:seller).permit %i[name email password password_confirmation]
  end
end

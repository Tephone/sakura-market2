class Admins::SellersController < Admins::ApplicationController
  before_action :set_seller, only: %i[show edit update destroy]

  def index
    @sellers = Seller.default_order.page(params[:page])
  end

  def new
    @seller = Seller.new
  end

  def create
    @seller = Seller.new(create_seller_params)
    if @seller.save
      redirect_to admins_sellers_path, notice: '業者を作成しました'
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @seller.update(update_seller_params)
      redirect_to admins_seller_path(@seller), notice: '業者を更新しました'
    else
      render :edit
    end
  end

  def destroy
    @seller.destroy!
    redirect_to admins_sellers_path, notice: '業者を削除しました'
  end

  private

  def create_seller_params
    params.require(:seller).permit %i[name email password password_confirmation]
  end

  def update_seller_params
    params.require(:seller).permit %i[name email capacity_per_box capacity_per_box]
  end

  def set_seller
    @seller = Seller.find(params[:id])
  end
end

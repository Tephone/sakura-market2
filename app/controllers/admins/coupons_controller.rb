class Admins::CouponsController < Admins::ApplicationController
  before_action :set_coupon, only: %i[show edit update destroy]

  def index
    @coupons = Coupon.default_order.page(params[:page])
  end

  def new
    @coupon = Coupon.new
  end

  def create
    @coupon = Coupon.new(coupon_params)
    if @coupon.save
      redirect_to admins_coupons_path, notice: 'クーポンを作成しました'
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @coupon.update(coupon_params)
      redirect_to admins_coupons_path, notice: 'クーポン情報を更新しました'
    else
      render :edit
    end
  end

  def destroy
    @coupon.destroy!
    redirect_to admins_coupons_path, notice: 'クーポン情報を削除しました'
  end

  private

  def coupon_params
    params.require(:coupon).permit %i[code point]
  end

  def set_coupon
    @coupon = Coupon.find(params[:id])
  end
end

class Users::UserCouponsController < Users::ApplicationController
  def index
    @coupons = current_user.user_coupons.default_order.page(params[:page])
  end

  def new
    @user_coupon = current_user.user_coupons.new
  end

  def create
    @user_coupon = current_user.user_coupons.new(user_coupon_params)
    if @user_coupon.save
      redirect_to users_mypage_path(current_user), notice: 'クーポンを取得しました'
    else
      render :new
    end
  end

  private

  def user_coupon_params
    params.require(:user_coupon).permit(:code)
  end
end

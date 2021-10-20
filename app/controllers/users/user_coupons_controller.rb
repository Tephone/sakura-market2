class Users::UserCouponsController < Users::ApplicationController
  def index
    @coupons = current_user.user_coupons.default_order.page(params[:page])
  end

  def new
    @user_coupon = current_user.user_coupons.new
  end

  def create
    coupon = Coupon.find { |coupon| coupon.code == params[:user_coupon][:code]}
    @user_coupon = current_user.user_coupons.new(coupon_id: coupon&.id)
    if @user_coupon.save
      redirect_to users_mypage_path(current_user), notice: 'クーポンを取得しました'
    else
      flash.now[:alert] = 'クーポンコードが間違っています'
      render :new
    end
  end
end

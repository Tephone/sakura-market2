class Users::MypagesController < Users::ApplicationController
  def show
    @user = current_user
  end
end

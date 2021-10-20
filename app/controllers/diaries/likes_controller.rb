class Diaries::LikesController < Users::ApplicationController
  def create
    @like = current_user.likes.new(diary_id: params[:diary_id])
    @like.save!
    redirect_to diaries_path
  end

  def destroy
    @like = current_user.likes.find(params[:id])
    @like.destroy!
    redirect_to diaries_path
  end
end

class Diaries::CommentsController < ApplicationController
  before_action :set_diary, only: %i[create destroy]

  def create
    @comment = current_user.comments.new(comment_params)
    @comment.diary_id = @diary.id
    if @comment.save
      redirect_to diary_path(@comment.diary_id), notice: 'コメントを作成しました'
    else
      redirect_to diary_path(@comment.diary_id), alert: 'コメントの作成に失敗しました'
    end
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    @comment.destroy!
    redirect_to diary_path(@diary), notice: 'コメントを削除しました'
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def set_diary
    @diary = Diary.find(params[:diary_id])
  end
end

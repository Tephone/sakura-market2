class Users::DiariesController < Users::ApplicationController
  before_action :set_diary, only: %i[show edit update destroy]

  def index
    @diaries = current_user.diaries.date_desc.page(params[:page])
  end

  def new
    @diary = current_user.diaries.new
  end

  def create
    @diary = current_user.diaries.new(diary_params)
    if @diary.save
      redirect_to users_diaries_path, notice: '日記を作成しました'
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @diary.update(diary_params)
      redirect_to users_diary_path(@diary), notice: '日記を更新しました'
    else
      render :edit
    end
  end

  def destroy
    @diary.destroy!
    redirect_to users_diaries_path, notice: '日記を削除しました'
  end

  private

  def diary_params
    params.require(:diary).permit %i[user_id content image date]
  end

  def set_diary
    @diary = current_user.diaries.find(params[:id])
  end
end

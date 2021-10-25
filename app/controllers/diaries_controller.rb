class DiariesController < Users::ApplicationController
  def index
    @diaries = Diary.date_desc.page(params[:page])
  end

  def show
    @diary = Diary.find(params[:id])
  end
end

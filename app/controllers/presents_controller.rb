class PresentsController < ApplicationController
  before_action :present_correct_user, only:[:update, :destroy]

  def show
  end

  def create
    present = current_user.presents.build(present_params)
    @main = Main.find_by(params[:main_id])
    present.main_id = @main.id

    if present.save
      flash[:success] = '報告内容を追加しました'
      redirect_to main_url(@main)
    else
      @presents = Present.where(main_id: params[:id])
      flash.now[:danger] = '報告会内容の追加に失敗しました'
      render main
    end
  end

  def update
    if @present.update(present_params)
      flash[:success] = '報告内容を変更しました'
      redirect_to main_url(@present.main)
    else
      flash[:danger] = '報告内容の変更に失敗しました'
      redirect_to main_url(@present.main)
    end
  end

  def destroy
  end

  private

  def present_params
    params.require(:present).permit(:title)
  end

  def present_correct_user
    @present = current_user.presents.find_by(id: params[:id])
    unless @present
      redirect_to main_url(@present.main)
    end
  end
end

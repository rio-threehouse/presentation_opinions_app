class MainsController < ApplicationController
  before_action :require_user_logged_in
  before_action :main_correct_user, only:[:update, :destroy]
  
  def show
  end

  def create
    @main = current_user.mains.build(main_params)

    if @main.save
      flash[:success] = '報告会を追加しました'
      redirect_to root_url
    else
      @mains = Main.all.order("created_at DESC").page(params[:page])
      flash[:danger] = '報告会の追加に失敗しました'
      render 'toppages/index'
    end
  end

  def update
  end

  def destroy
    @main.destroy
    flash[:danger] = '報告会を削除しました'
    redirect_to root_url
  end

  private

  def main_params
    params.require(:main).permit(:title, :date, :time)
  end

  def main_correct_user
    @main = current_user.mains.find_by(id: params[:id])
    unless @main
      redirect_to root_url
    end
  end
end

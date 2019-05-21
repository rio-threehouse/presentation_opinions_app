class MainsController < ApplicationController
  before_action :require_user_logged_in
  before_action :main_correct_user, only:[:edit, :update, :destroy]

  def show
  end

  def create
    @main = current_user.mains.build(main_params)

    if @main.save
      flash[:success] = '報告会を追加しました'
      redirect_to root_url
    else
      @mains = Main.all.order("date DESC").page(params[:page]).per(8)
      flash[:danger] = '報告会の追加に失敗しました'
      render 'toppages/index'
    end
  end

  def edit
    @main = Main.find_by(id: params[:id])
  end

  def update
    if @main.update(main_params)
      flash[:success] = '報告会の内容を変更しました'
      redirect_to edit_main_url(@main)
    else
      flash[:danger] = '報告会の内容変更に失敗しました'
      render :edit
    end
  end

  def destroy
    @main.destroy
    flash[:danger] = '報告会を削除しました'
    redirect_to root_url
  end

  private

  def main_params
    params.require(:main).permit(:title, :date, :time, :group)
  end

  def main_correct_user
    @main = current_user.mains.find_by(id: params[:id])
    unless @main
      redirect_to root_url
    end
  end
end

class MainsController < ApplicationController
  before_action :require_user_logged_in
  # updateとdestroyはuser_idがcurrent_user.idのユーザのみ
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
  end

  private

  def main_params
    params.require(:main).permit(:title, :date, :time)
  end
end

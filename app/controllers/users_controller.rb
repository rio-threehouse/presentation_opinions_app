class UsersController < ApplicationController
  before_action :require_user_logged_in, only:[:edit, :update, :destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'アカウントを作成しました'
      redirect_to login_url
    else
      flash.now[:danger] = 'アカウントの登録に失敗しました'
      render :new
    end
  end

  def edit
  end

  def update
    if current_user.update(user_params)
      flash[:success] = 'アカウント情報を変更しました'
      redirect_to edit_user_url(current_user)
    else
      flash.now[:danger] = 'アカウント情報の変更に失敗しました'
      render :edit
    end
  end

  def destroy
    current_user.destroy
    flash[:danger] = 'アカウントを削除しました'
    redirect_to root_url
  end

  private

  def user_params
    params.require(:user).permit(:name, :name_read, :research, :password, :password_confirmation)
  end
end

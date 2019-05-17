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
  end

  def destroy
  end

  private

  def user_params
    params.require(:user).permit(:name, :name_confirmation, :password, :password_confirmation)
  end
end

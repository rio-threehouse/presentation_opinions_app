class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'アカウントを作成しました'
      redirect_to root_url
    else
      flash[:danger] = 'アカウントの作成に失敗しました'
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
    params.require(:user).permit(:name, :name_confirmation)
  end
end

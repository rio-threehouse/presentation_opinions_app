class UsersController < ApplicationController
  before_action :require_user_logged_in, only:[:edit, :update, :destroy]
  before_action :user_correct_user, only:[:show]
  before_action :digest_authentication, only:[:new]
  REALM = 'SecretZone'.freeze
  USERS = { ENV["DIGEST_AUTH_NAME"] => Digest::MD5.hexdigest([ENV["DIGEST_AUTH_NAME"], REALM, ENV["DIGEST_AUTH_PASSWORD"]].join(':'))}.freeze

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

  def show
    @presents = Present.where(user_id: params[:id]).order('updated_at DESC')
  end

  private

  def digest_authentication
    authenticate_or_request_with_http_digest(REALM) do |username|
      USERS[username]
    end
  end

  def user_params
    params.require(:user).permit(:name, :name_read, :research, :password, :password_confirmation)
  end

  def user_correct_user
    unless current_user == User.find(params[:id])
      redirect_to root_url
    end
  end
end

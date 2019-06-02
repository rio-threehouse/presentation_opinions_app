class MainsController < ApplicationController
  before_action :require_user_logged_in
  before_action :main_correct_user, only:[:edit, :update, :destroy]
  before_action :group0, only:[:show]
  # before_action :group1, only:[:group1]

  def show
    show_data
  end

  def field
    show_data
    @field_presents = @presents.where(research: 'フィールドサイエンス').order("name_read")
  end

  def human
    show_data
    @human_presents = @presents.where(research: 'ヒューマンサイエンス').order("name_read")
  end

  def data
    show_data
    @data_presents = @presents.where(research: 'データサイエンス').order("name_read")
  end

  def life
    show_data
    @life_presents = @presents.where(research: 'ライフスタイル').order("name_read")
  end

  def manage
    show_data
    @manage_presents = @presents.where(research: 'マネジメント').order("name_read")
  end

  def group1
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
  
  def show_data
    @main = Main.find(params[:id])
    @presents = Present.where(main_id: params[:id]).order("research")
    @present = current_user.presents.build
    @current_user_present = @presents.find_by(user_id: current_user.id)
  end

  def main_correct_user
    @main = current_user.mains.find_by(id: params[:id])
    unless @main
      redirect_to root_url
    end
  end

  def group0
    @main = Main.find_by(id: params[:id])
    unless @main.group == '0'
      redirect_to group1_main_path(@main)
    end
  end

  # def group1
  #   @main = Main.find_by(id: params[:id])
  #   unless @main.group == '1'
  #     redirect_to main_path(@main)
  #   end
  # end
end

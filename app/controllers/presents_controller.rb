class PresentsController < ApplicationController
  before_action :present_correct_user, only:[:edit, :update, :destroy]

  def show
  end

  def create
    present = current_user.presents.build(present_params)
    main = Main.find(params[:main_id])
    present.main_id = main.id
    present.name_read = params[:name_read]
    present.research = params[:research]

    if present.save
      flash[:success] = '報告内容を追加しました'
      redirect_back(fallback_location: root_path)
    else
      @presents = Present.where(main_id: params[:id])
      flash[:danger] = '報告会内容の追加に失敗しました'
      redirect_back(fallback_location: root_path)
    end
  end

  def edit
  end

  def update
    @present.name_read = params[:name_read]
    @present.research = params[:research]
    if @present.update(present_params)
      flash[:success] = '報告内容を変更しました'
      redirect_to edit_present_url(@present)
    else
      flash.now[:danger] = '報告内容の変更に失敗しました'
      render :edit
    end
  end

  def destroy
    @present.destroy
    flash[:success] = '報告内容を削除しました'
    redirect_to main_url(@present.main)
  end

  private

  def present_params
    params.require(:present).permit(:title)
  end

  def present_correct_user
    @present = current_user.presents.find_by(id: params[:id])
    unless @present
      redirect_to root_url
    end
  end
end

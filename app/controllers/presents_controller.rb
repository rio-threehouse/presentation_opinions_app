class PresentsController < ApplicationController
  before_action :require_user_logged_in
  before_action :present_correct_user, only:[:edit, :update, :destroy]
  before_action :owner_page, only:[:owner, :tag1, :tag2, :tag3, :tag4]

  def show
    @present = Present.find(params[:id])
    @comments = @present.comments.where(user_id: current_user.id).order('updated_at DESC')
    @comment = current_user.comments.build
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

  def owner
    owner_data
  end

  def tag1
    owner_data
    @tag1 = @comments.where(tag: '指摘').page(params[:page])
  end

  def tag2
    owner_data
    @tag2 = @comments.where(tag: '疑問').page(params[:page])
  end

  def tag3
    owner_data
    @tag3 = @comments.where(tag: '感想').page(params[:page])
  end

  def tag4
    owner_data
    @tag4 = @comments.where(tag: 'その他').page(params[:page])
  end

  private

  def owner_data
    @present = Present.find(params[:id])
    @comments = Comment.where(present_id: params[:id]).order('updated_at DESC').page(params[:page])
    counts(@present)
  end
  
  def present_params
    params.require(:present).permit(:title)
  end

  def present_correct_user
    @present = current_user.presents.find_by(id: params[:id])
    unless @present
      redirect_to root_url
    end
  end

  def owner_page
    @present = current_user.presents.find_by(id: params[:id])
    unless @present || current_user.research == 'teacher'
      redirect_to root_url
    end
  end

  def counts(present)
    @comment_counts = present.comments.count
    @tag1_counts = present.comments.where(tag: '指摘').count
    @tag2_counts = present.comments.where(tag: '疑問').count
    @tag3_counts = present.comments.where(tag: '感想').count
    @tag4_counts = present.comments.where(tag: 'その他').count
  end
end

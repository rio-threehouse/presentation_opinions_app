class CommentsController < ApplicationController
  before_action :require_user_logged_in
  before_action :comment_correct_user, only:[:edit, :update, :destroy]

  def create
    @comment = current_user.comments.build(comment_params)
    @comment.present_id = params[:present_id]

    if @comment.save
      flash[:success] = '投稿しました'
      redirect_back(fallback_location: root_path)
    else
      @present = Present.find(params[:present_id])
      @comments = @present.comments.where(user_id: current_user.id).order('updated_at DESC')
      flash[:danger] = '投稿に失敗しました'
      render 'presents/show'
    end
  end

  def edit
    @present = @comment.present
  end

  def update
    if @comment.update(comment_params)
      flash[:info] = '投稿内容を変更しました'
      redirect_to @comment.present
    else
      @present = @comment.present
      flash[:danger] = '投稿内容の変更に失敗しました'
      render :edit
    end

  end

  def destroy
    @comment.destroy
    flash[:danger] = '投稿を削除しました'
    redirect_back(fallback_location: root_path)
  end

  private

  def comment_params
    params.require(:comment).permit(:tag, :comment)
  end

  def comment_correct_user
    @comment = current_user.comments.find_by(id: params[:id])
    unless @comment
      redirect_to root_url
    end
  end
end

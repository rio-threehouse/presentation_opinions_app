class CommentsController < ApplicationController
  before_action :require_user_logged_in
  before_action :comment_correct_user, only:[:edit, :update, :destroy]

  def create
    @comment = current_user.comments.build(comment_params)
    @comment.present_id = params[:present_id]

    if @comment.save
      flash[:success] = 'コメントしました'
      redirect_back(fallback_location: root_path)
    else
      flash[:danger] = 'コメントの投稿に失敗しました'
      redirect_back(fallback_location: root_path)
    end
  end

  def edit
    @present = @comment.present
  end

  def update
    if @comment.update(comment_params)
      flash[:info] = 'コメント内容を変更しました'
      redirect_to @comment.present
    else
      @present = @comment.present
      flash[:danger] = 'コメント内容の変更に失敗しました'
      render :edit
    end

  end

  def destroy
    @comment.destroy
    flash[:danger] = 'コメントを削除しました'
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

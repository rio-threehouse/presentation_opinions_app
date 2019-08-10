class ChecksController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    @comment = Comment.find(params[:comment_id])
    current_user.check(@comment)
    # flash[:success] = 'チェックしました'
    # redirect_back(fallback_location: root_path)
  end

  def destroy
    @comment = Comment.find(params[:comment_id])
    current_user.uncheck(@comment)
    # flash[:danger] = 'チェックを取り消しました'
    # redirect_back(fallback_location: root_path)
  end
end

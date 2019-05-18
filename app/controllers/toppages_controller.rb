class ToppagesController < ApplicationController
  def index
    if logged_in?
      @main = current_user.mains.build
      @mains = Main.all.order("date DESC").page(params[:page]).per(8)
    end
  end
end

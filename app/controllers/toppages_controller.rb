class ToppagesController < ApplicationController
  def index
    if logged_in?
      @main = current_user.mains.build
      @mains = Main.where.not(date: Date.today).order("date DESC").page(params[:page]).per(8)
      @today_mains = Main.where(date: Date.today)
    end
  end
end

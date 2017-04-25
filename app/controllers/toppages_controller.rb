class ToppagesController < ApplicationController
  def index
    if logged_in?
      @user = current_user
      @usertask = current_user.usertasks.build
      @usertasks = current_user.usertasks.order('created_at DESC').page(params[:page])
    end
  end
end

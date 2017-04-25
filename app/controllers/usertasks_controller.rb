class UsertasksController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    @usertask = current_user.usertasks.build(usertask_params)
    if @usertask.save
      flash[:success] = '投稿しました。'
      redirect_to root_url
    else
      @usertasks = current_user.usertasks.order('created_at DESC').page(params[:page])
      flash.now[:danger] = '投稿に失敗しました。'
      render 'toppages/index'
    end
  end

  def destroy
    @usertask.destroy
    flash[:success] = '削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  def usertask_params
    params.require(:usertask).permit(:cuntent)
  end
  
  def correct_user
    @usertask = current_user.usertasks.find_by(id: params[:id])
    unless @usertask
      redirect_to root_path
    end
  end
end

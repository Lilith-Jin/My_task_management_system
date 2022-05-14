class Admin::UsersController < ApplicationController
  def index
    @users = User.includes(:tasks).where.not(id: current_user.id).page(params[:page]).per(10)
   
  end
end

class Admin::UsersController < ApplicationController
  before_action :find_user, only: %i[edit update destroy]

  def index
    @users = User.includes(:tasks).where.not(id: current_user.id).page(params[:page]).per(10)
  end

  def edit

  end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path, notice: I18n.t('user.message.success_update')
    else
      render :edit, notice: I18n.t(user.message.failed_update)
    end
  end

  private 

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :role)
  end

  def find_user
    @user = User.find(params[:id])
  end
end

# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!, only: %i[edit, update]
  before_action :current_user, only: %i[edit, update]
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login(@user)
      redirect_to tasks_path, notice: I18n.t('user.message.success_register')
    else
      render :new
    end
  end

  def edit
    
  end

  def update
    if current_user.update(user_params)
      redirect_to tasks_path, notice: I18n.t('user.message.success_update')
    else
      render :edit, notice: I18n.t('user.message.failed_update')
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :role)
  end

end

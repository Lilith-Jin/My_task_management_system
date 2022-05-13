# frozen_string_literal: true

class UsersController < ApplicationController
  def sign_up
    @user = User.new
  end

  def registering
    @user = User.new(user_params)
    if @user.save
      redirect_to tasks_path, notice: I18n.t('user.message.success_register')
    else
      render :sign_up
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :role)
  end
end

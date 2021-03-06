# frozen_string_literal: true

class SessionsController < ApplicationController
  def create
    user = User.find_by(email: user_params[:email])

    if user&.authenticate(user_params[:password])
      login(user)
      redirect_to tasks_path, notice: I18n.t('user.message.success_login')
    else
      redirect_to login_path, notice: I18n.t('user.message.failed_login')
    end
  end

  def destroy
    session[:session] = nil
    redirect_to root_path, notice: I18n.t('user.message.success_logout'), status: :see_other
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end

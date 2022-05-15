# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def login(user)
    session[:session] = user.id
  end

  private

  def current_user
    @current_user || User.find_by(id: session[:session])
  end

  def authenticate_user!
    redirect_to login_path, notice: I18n.t('user.message.login_first') unless current_user
  end
end

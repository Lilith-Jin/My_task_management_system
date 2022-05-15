# frozen_string_literal: true

module ApplicationHelper
  def user_sign_in?
    session[:session].present?
  end
end

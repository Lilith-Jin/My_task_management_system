class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    user = User.find_by(email: params[:user][:email])
    # digest = BCrypt::Password.create(params[:password])
    if user&.authenticate(params[:user][:password])
        login(user)
        redirect_to tasks_path, notice: "登入成功"
    else
        redirect_to :login, alert: "帳號密碼組合不正確，請重新嘗試"
    end
  end

  def logout
    session[:session] = nil
    redirect_to root_path, notice: "登出成功，下次見!"
  end
    
end

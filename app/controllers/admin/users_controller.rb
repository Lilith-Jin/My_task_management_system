# frozen_string_literal: true

module Admin
  class UsersController < ApplicationController
    before_action :find_user, only: %i[edit update destroy]
    before_action :check_role, only: %i[index edit update destroy]

    def index
      @users = User.includes(:tasks).where.not(id: current_user.id).page(params[:page]).per(10)
    end

    def edit; end

    def update
      if @user.update(user_params)
        redirect_to admin_users_path, notice: I18n.t('user.message.success_update')
      else
        render :edit, notice: I18n.t(user.message.failed_update)
      end
    end

    def destroy
      @user.destroy
      redirect_to admin_users_path, status: :see_other, notice: I18n.t('user.message.success_delete')
    end

    private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :role)
    end

    def find_user
      @user = User.find(params[:id])
    end

    def check_role
      unless current_user.role == "admin"
        redirect_to root_path, notice: I18n.t('user.message.role_admin')
      end
    end
  end
end

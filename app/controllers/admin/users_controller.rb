# frozen_string_literal: true

module Admin
  class UsersController < ApplicationController
    before_action :find_user, only: %i[edit update destroy]
    before_action :check_role

    def index
      @users = User.includes(:tasks).page(params[:page]).per(10)
    end

    def new
      @user = User.new
    end
  
    def create
      @user = User.new(user_params)
      if @user.save
        redirect_to admin_users_path, notice: I18n.t('user.message.success_register')
      else
        render :new
      end
    end

    def edit; end

    def update
      if @user.update(user_params)
        redirect_to admin_users_path, notice: I18n.t('user.message.success_update')
      else
        render :edit, alert: I18n.t('user.message.failed_update')
      end
    end

    def destroy
      if @user.destroy
        redirect_to admin_users_path, status: :see_other, notice: I18n.t('user.message.success_delete')
      else
        redirect_to admin_users_path, status: :see_other, alert: I18n.t('user.message.failed_delete')
      end
    end

    def update_role
      if @user.update(role: user_params[:role])
        redirect_to admin_users_path, notice: I18n.t('user.message.success_update')
      else
        render :edit, notice: I18n.t('user.message.failed_update')
      end
    end

    private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :role)
    end

    def find_user
      @user = User.find(params[:id])
    end

    def check_role
      redirect_to root_path, notice: I18n.t('user.message.role_admin') unless current_user.role == 'admin'
    end
  end
end

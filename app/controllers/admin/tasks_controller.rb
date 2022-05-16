# frozen_string_literal: true

module Admin
  class TasksController < ApplicationController
    before_action :find_user, only: %i[index]
    def index
      @q = @user.tasks.ransack(params[:q])
      @tasks = @q.result(distinct: true).order('end_time').page(params[:page]).per(10)
    end

    private

    def find_user
      @user = User.find(params[:user_id])
    end
  end
end

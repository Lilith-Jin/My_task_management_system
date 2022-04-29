class TasksController < ApplicationController
  before_action :find_task, only: [:edit, :update, :show, :destroy]
  def index
    @tasks = Task.all
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_path, notice: I18n.t('task.message.success_create')
    else
      render :new
    end
  end

  def edit
    # byebug
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: I18n.t('task.message.success_update')
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, status: :see_other, notice: I18n.t('task.message.success_delete')
  end

  private

  def task_params
    params.require(:task).permit(:title, :content, :priority, :status, :start_time, :end_time)
  end

  def find_task
    @task = Task.find(params[:id])
  end
end


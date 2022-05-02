class TasksController < ApplicationController
  before_action :find_task, only: [:edit, :update, :show, :destroy]
  def index
    @tasks = Task.order('created_at DESC')
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_path, notice: "新增任務成功"
    else
      render :new
    end
  end

  def edit
    # byebug
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: "更新任務成功"
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, status: :see_other, notice: "任務已刪除"
  end

  private

  def task_params
    params.require(:task).permit(:title, :content, :priority, :status, :start_time, :end_time)
  end

  def find_task
    @task = Task.find(params[:id])
  end
end


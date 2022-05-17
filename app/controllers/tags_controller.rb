class TagsController < ApplicationController
 
  before_action :authenticate_user!

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(tag_params)
    @task = Task.find(params[:task_id])
    if @tag.save
      TaskTag.create(tag_id: @tag.id, task_id: @task.id)
      redirect_to tasks_path, notice: '新增標籤成功!'
    else
      render :new, notice: '請輸入標籤名稱!' 
    end
  end

  private

  def find_task
    @task = Task.find(params[:task_id])
  end

  def tag_params
    params.require(:tag).permit(:name)
  end
end

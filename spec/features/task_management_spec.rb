require "rails_helper"

RSpec.feature "task management", :type => :feature do
  context 'create new task' do
    scenario "Successfuly creates a new task" do
      visit tasks_path
      click_link("新增任務")

      expect(current_path).to have_content('tasks/new')
      within("form") do 
          fill_in 'task_title', with:"task1"
          fill_in 'task_content', with:"123"
          fill_in 'task_start_time', with: DateTime.now
          fill_in 'task_end_time', with: DateTime.now
          select 'high', from: 'task_priority'
          select'running', from: 'task_status'
    end

      click_button "新增任務"

      expect(page).to have_text("新增任務成功")
    end
  end

  context 'update new task' do
    scenario "Successfuly updates a new task" do
      task = Task.create(title:"task1", content:"123", start_time: DateTime.now, end_time: DateTime.now ,priority:"high", status:"running")
      # visit edit_task_path(task)
      visit tasks_path
      click_link("編輯任務")

      expect(current_path).to have_content(edit_task_path(task))
      within("form") do 
          fill_in 'task_title', with:"task1"
          fill_in 'task_content', with:"123"
          fill_in 'task_start_time', with: DateTime.now
          fill_in 'task_end_time', with: DateTime.now
          select 'high', from: 'task_priority'
          select'running', from: 'task_status'
    end

      click_button "更新任務"

      expect(page).to have_text("更新任務成功")
      
    end
  end
  context 'task index' do
    scenario "Successfuly delete a task" do
      task = Task.create(title:"task1", content:"123", start_time: DateTime.now, end_time: DateTime.now ,priority:"high", status:"running")
      visit tasks_path
    
      click_link '刪除任務'

      expect(click_link '刪除任務').to change(Task, :count).by(-1)
      expect(page).to have_content '任務已刪除'
    end
  end

end
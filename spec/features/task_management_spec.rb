require "rails_helper"

RSpec.feature "task management", :type => :feature do
  context 'create new task' do
    scenario "Successfuly creates a new task" do
      visit "/tasks/new"
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
      # expect(page).to have_field('task_start_time', with: Time.new(2022, 04, 29, 12))
    end
  end

  context 'update new task' do
    scenario "Successfuly updates a new task" do
      task = Task.create(title:"task1", content:"123", start_time: DateTime.now, end_time: DateTime.now ,priority:"high", status:"running")
      visit edit_task_path(task)
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

#   scenario "Successfuly delete a task" do
#     task = Task.create(title:"task1", content:"123", start_time:"202204080800", end_time:"202204080800",priority:"high", status:"running")
#     visit tasks_path
#     click_button '刪除任務'
#     expect(page).to have_content '任務已刪除'
#   end
end
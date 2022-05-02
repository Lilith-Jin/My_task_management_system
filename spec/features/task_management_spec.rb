require "rails_helper"

RSpec.feature "task_management", :type => :feature do
  context 'task CRUD' do
    let!(:task) { FactoryBot.create (:task) }
    it 'Successfuly creates a new task' do
      visit tasks_path
      click_link('新增任務')
      expect(current_path).to have_content('tasks/new')
      within('form') do 
        fill_in 'task_title', with: 'task1'
        fill_in 'task_content', with: '123'
        fill_in 'task_start_time', with: Time.now
        fill_in 'task_end_time', with: Time.now
        select 'high', from: 'task_priority'
        select 'running', from: 'task_status'
      end
      click_button '新增任務'
      expect(page).to have_text('新增任務成功')
      expect(current_path).to have_content(tasks_path)
    end

    it 'Successfuly updates a new task' do
      visit tasks_path
      task = Task.find_by(title: 'task1')
      click_link('編輯任務')
      expect(current_path).to have_content(edit_task_path(task))
      within('form') do 
        fill_in 'task_title', with: 'task2'
      end
      click_button '更新任務'
      expect(page).to have_text('更新任務成功')
      expect(current_path).to have_content(tasks_path)
    end

    it 'Successfuly read a task' do
      visit tasks_path
      task = Task.find_by(title: 'task1')
      click_link '查看任務'
      expect(current_path).to have_content(task_path(task))
      click_link '返回上一頁'
      expect(current_path).to have_content(tasks_path)
    end

    it 'Successfuly delete a task', driver: :selenium_chrome, js: true do
      visit tasks_path
      task = Task.find_by(title: 'task1')
      find(:xpath, "//a[@href='/tasks/#{task.id}']", text: '刪除任務').click
      accept_alert(text: '您確定要刪除嗎？')
      expect(page).to have_current_path(tasks_path)
      expect(page).to have_content('任務已刪除')
    end
  end
end
require "rails_helper"

RSpec.feature 'task_management', :type => :feature do
  context 'with task CRUD' do
    let!(:task) { FactoryBot.create (:task) }
    it 'Link to creates a new task' do
      visit tasks_path
      click_link('新增任務')
      expect(page).to have_current_path(new_task_path)
    end
    it 'Successfuly creates a new task' do
      visit new_task_path
      fill_data
      click_button '新增任務'
      expect_new_task_result
    end

    def expect_new_task_result
      expect(page).to have_text('新增任務成功')
      expect(page).to have_current_path(tasks_path)
      # result = { 'title' => 'task1', 'content' => 'content_new', 'start_time'=> task.start_time, 'end_time'=> task.end_time, 'priority'=>'high', 'status'=>'waiting'}
      # expect(task.attributes.slice('title', 'content', 'start_time', 'end_time', 'priority', 'status')).to eq(fill_data)
    end

    it 'Link to edit a task' do
      visit tasks_path
      click_link('編輯任務')
      expect(current_path).to have_content(edit_task_path(task))
    end

    it 'Successfuly updates a new task' do
      visit edit_task_path(task)
      p fill_data
      click_button '更新任務'
      expect_edit_task_result
    end

    def expect_edit_task_result
      expect(page).to have_text('更新任務成功')
      expect(page).to have_current_path(tasks_path)
    end

    def fill_data
      within('form') do
        fill_in 'task_title', with: task.title
        fill_in 'task_content', with: task.content
        fill_in 'task_start_time', with: task.start_time
        fill_in 'task_end_time', with: task.end_time
        find_field('task_priority').find('option[selected]').text
        find_field('task_status').find('option[selected]').text
      end
    end

    # it 'Link to read a task' do
    #   visit tasks_path
    #   find(task)
    #   click_link '查看任務'
    #   expect(current_path).to have_content(task_path(task))
    # end

    # it 'Successfuly read a task' do
    #   click_link '返回上一頁'
    #   expect(current_path).to have_content(tasks_path)
    # end

    # it 'Successfuly delete a task', driver: :selenium_chrome, js: true do
    #   visit tasks_path
    #   task = Task.find_by(title: 'task1')
    #   find(:xpath, "//a[@href='/tasks/#{task.id}']", text: '刪除任務').click
    #   accept_alert(text: '您確定要刪除嗎？')
    #   expect(page).to have_current_path(tasks_path)
    #   expect(page).to have_content('任務已刪除')
    # end
  end
end
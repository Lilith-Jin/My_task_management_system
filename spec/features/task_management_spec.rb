# frozen_string_literal: true

RSpec.describe 'task management', type: :feature do
  context 'with task CRUD' do
    let!(:task) { FactoryBot.create (:task) }
    it 'Link to creates a new task' do
      visit tasks_path
      click_link(I18n.t('task.action.create'))
      expect(page).to have_current_path(new_task_path)
    end
    it 'Successfuly creates a new task' do
      visit new_task_path
      fill_data
      click_button I18n.t('task.action.create')
      expect_new_task_result
    end

    def expect_new_task_result
      expect(page).to have_text(I18n.t('task.message.success_create'))
      expect(page).to have_current_path(tasks_path)
      # result = { 'title' => 'task1', 'content' => 'content_new', 'start_time'=> task.start_time, 'end_time'=> task.end_time, 'priority'=>'high', 'status'=>'waiting'}
      # expect(task.attributes.slice('title', 'content', 'start_time', 'end_time', 'priority', 'status')).to eq(fill_data)
    end

    it 'Link to edit a task' do
      visit tasks_path
      click_link(I18n.t('task.action.update'))
      expect(current_path).to have_content(edit_task_path(task))
    end

    it 'Successfuly updates a new task' do
      visit edit_task_path(task)
      p fill_data
      click_button(I18n.t('task.action.update'))
      expect_edit_task_result
    end

    def expect_edit_task_result
      expect(page).to have_text(I18n.t('task.message.success_update'))
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

    it 'Link to read a task' do
      visit tasks_path
      click_link I18n.t('task.action.show')
      expect(page).to have_current_path(task_path(task))
      click_link I18n.t('task.action.back')
      expect(page).to have_current_path(tasks_path)
    end

    it 'Successfuly delete a task', driver: :selenium_chrome, js: true do
      visit tasks_path
      find(:xpath, "//a[@href='/tasks/#{task.id}']", text: I18n.t('task.action.delete')).click
      accept_alert(text: I18n.t('task.message.confirm_delete'))
      expect_destroy_task_result
    end

    def expect_destroy_task_result
      expect(page).to have_current_path(tasks_path)
      expect(page).to have_content(I18n.t('task.message.success_delete'))
      expect(Task.find_by(title: 'task1')).to be_nil
    end
  end
end

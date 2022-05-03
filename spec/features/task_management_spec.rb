# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'task management', type: :feature do
  context 'with tasks CRUD' do
    it 'Link to creates a new task' do
      visit tasks_path
      click_link(I18n.t('task.action.create'))
      expect(page).to have_current_path(new_task_path)
    end

    it 'Successfuly creates a new task' do
      visit new_task_path
      fill_data(title: 'task1', content: '123')
      click_button I18n.t('task.action.create')
      expect_new_task_result
    end

    def expect_new_task_result
      expect(page).to have_text(I18n.t('task.message.success_create'))
      expect(page).to have_current_path(tasks_path)
      # 另開分支修改
      # result = { 'title' => 'task1', 'content' => '123'}
      # expect(Task.last.attributes).to eq(result)
    end

    it 'Link to updates the task' do
      task = Task.create(title: 'task1', content: '123', start_time: Time.zone.now, end_time: Time.zone.now,
                         priority: 'high', status: 'waiting')
      visit tasks_path
      click_link(I18n.t('task.action.update'))
      expect(page).to have_current_path(edit_task_path(task))
    end

    it 'Successfuly updates the task' do
      task = Task.create(title: 'task1', content: '123', start_time: Time.zone.now, end_time: Time.zone.now,
                         priority: 'high', status: 'waiting')
      visit edit_task_path(task)
      fill_data(title: 'task1', content: 'content_new')
      click_button I18n.t('task.action.update')
      expect_edit_task_result
    end

    def expect_edit_task_result
      expect(page).to have_text(I18n.t('task.message.success_update'))
      expect(page).to have_current_path(tasks_path)
      # 另開分支修改
      # result = { 'title' => 'task1', 'content' => 'content_new', 'start_time'=> Time.now, 'end_time'=> Time.now, 'priority'=>'high', 'status'=>'waiting'}
      # expect(Task.last.attributes.slice('title', 'content', 'start_time', 'end_time', 'priority', 'status')).to eq(result)
    end

    def fill_data(title:, content:)
      within('form') do
        fill_in 'task_title', with: title
        fill_in 'task_content', with: content
        fill_in 'task_start_time', with: Time.zone.now
        fill_in 'task_end_time', with: Time.zone.now
        find_field('task_priority').find('option[selected]').text
        find_field('task_status').find('option[selected]').text
      end
    end

    it 'Link to read a task' do
      task = Task.create(title: 'task1', content: '123', start_time: Time.zone.now, end_time: Time.zone.now,
                         priority: 'high', status: 'waiting')
      visit tasks_path
      click_link I18n.t('task.action.show')
      expect(page).to have_current_path(task_path(task))
      click_link I18n.t('task.action.back')
      expect(page).to have_current_path(tasks_path)
    end

    it 'Successfuly delete a task', driver: :selenium_chrome, js: true do
      task = Task.create(title: 'task1', content: '123456', start_time: Time.zone.now, end_time: Time.zone.now,
                         priority: 'high', status: 'waiting')
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

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'task management', type: :feature do
  context 'create new task' do
    it 'Successfuly creates a new task' do
      visit tasks_path
      click_link(I18n.t('task.action.create'))

      expect(current_path).to have_content('tasks/new')
      within('form') do
        fill_in 'task_title', with: 'task1'
        fill_in 'task_content', with: '123'
        fill_in 'task_start_time', with: DateTime.now
        fill_in 'task_end_time', with: DateTime.now
        select 'high', from: 'task_priority'
        select 'running', from: 'task_status'
      end

      click_button I18n.t('task.action.create')

      expect(page).to have_text(I18n.t('task.message.success_create'))
      expect(current_path).to have_content(tasks_path)
    end
  end

  context 'update new task' do
    it 'Successfuly updates a new task' do
      task = Task.create(title: 'task1', content: '123', start_time: DateTime.now, end_time: DateTime.now,
                         priority: 'high', status: 'running')

      visit tasks_path
      click_link(I18n.t('task.action.update'))

      expect(current_path).to have_content(edit_task_path(task))
      within('form') do
        fill_in 'task_title', with: 'task1'
        fill_in 'task_content', with: '123'
        fill_in 'task_start_time', with: DateTime.now
        fill_in 'task_end_time', with: DateTime.now
        select 'high', from: 'task_priority'
        select 'running', from: 'task_status'
      end

      click_button I18n.t('task.action.update')

      expect(page).to have_text(I18n.t('task.message.success_update'))
      expect(current_path).to have_content(tasks_path)
    end
  end

  context 'read task' do
    it 'Successfuly read a task' do
      task = Task.create(title: 'task1', content: '123', start_time: DateTime.now, end_time: DateTime.now,
                         priority: 'high', status: 'running')
      visit tasks_path

      click_link I18n.t('task.action.show')

      expect(current_path).to have_content(task_path(task))

      click_link I18n.t('task.action.back')
      expect(current_path).to have_content(tasks_path)
    end
  end

  context 'delete task' do
    it 'Successfuly delete a task', driver: :selenium_chrome, js: true do
      task = Task.create(title: 'task1', content: '123456', start_time: DateTime.now, end_time: DateTime.now,
                         priority: 'medium', status: 'running')
      visit tasks_path

      find(:xpath, "//a[@href='/tasks/#{task.id}']", text: I18n.t('task.action.delete')).click
      accept_alert(text: I18n.t('task.message.confirm_delete'))

      expect(page).to have_current_path(tasks_path)
      expect(page).to have_content(I18n.t('task.message.success_delete'))
    end
  end
end

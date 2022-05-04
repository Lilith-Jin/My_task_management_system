# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'task management', type: :feature do
  let!(:task) { FactoryBot.create(:task) }

  context 'with new page' do
    before do
      visit tasks_path
      click_link(I18n.t('task.action.create'))
    end

    it 'Link to creates a new task' do
      expect(page).to have_current_path(new_task_path)
      expect(page).to have_css('form')
    end

    it 'Successfuly creates a new task' do
      fill_data
      click_button I18n.t('task.action.create')
      expect(page).to have_content(task.title)
      expect(page).to have_text(I18n.t('task.message.success_create'))
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
  end

  context 'Update' do
    it 'Link to edit a task' do
      visit tasks_path
      click_link(I18n.t('task.action.update'))
      expect(current_path).to have_content(edit_task_path(task))
    end

    it 'Successfuly updates a new task' do
      visit edit_task_path(task)
      edit_data
      click_button(I18n.t('task.action.update'))
      expect_edit_task_result
    end

    def expect_edit_task_result
      expect(page).to have_text(I18n.t('task.message.success_update'))
      expect(page).to have_text('xxx')
      expect(page).to have_current_path(tasks_path)
    end

    def edit_data
      within('form') do
        fill_in 'task_title', with: 'xxx'
        fill_in 'task_content', with: task.content
        fill_in 'task_start_time', with: task.start_time
        fill_in 'task_end_time', with: task.end_time
        find_field('task_priority').find('option[selected]').text
        find_field('task_status').find('option[selected]').text
      end
    end
  end

  context 'with show page' do
    before do
      visit tasks_path
    end

    it 'Link to read a task' do
      click_link I18n.t('task.action.show')
      expect(page).to have_text(I18n.t('task.h1.show_task'))
      expect(page).to have_current_path(task_path(task))
    end

    it 'test back button' do
      click_link I18n.t('task.action.show')
      click_link I18n.t('task.action.back')
      expect(page).to have_current_path(tasks_path)
    end
  end

  context 'with task destroy' do
    it 'Successfuly delete a task', driver: :selenium_chrome, js: true do
      visit tasks_path
      find(:xpath, "//a[@href='/tasks/#{task.id}']", text: I18n.t('task.action.delete')).click
      accept_alert(text: I18n.t('task.message.confirm_delete'))
      expect_destroy_task_result
    end

    def expect_destroy_task_result
      expect(page).to have_current_path(tasks_path)
      expect(page).to have_content(I18n.t('task.message.success_delete'))
      expect(task).to be_nil
    end
  end
end

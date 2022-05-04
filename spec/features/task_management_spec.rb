# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'task management', type: :feature do
  let!(:task) { FactoryBot.create(:task) }
  subject { page}
  context 'with new page' do
    before do
      visit tasks_path
      click_link(I18n.t('task.action.create'))
    end

    describe 'Link to creates a new task' do
      it { is_expected.to have_current_path(new_task_path) }
      it { is_expected.to have_css('form') }

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
  end

  context 'with edit page' do
    before do
      visit tasks_path
      click_link(I18n.t('task.action.update'))
    end

    describe 'Link to edit a task' do
      it { is_expected.to have_current_path(edit_task_path(task)) }
      it 'Successfuly updates a task' do
        fill_in 'task_title', with: 'new title'
        click_button(I18n.t('task.action.update'))
        expect(page).to have_content('new title')
        expect(page).to have_text(I18n.t('task.message.success_update'))
      end
    end
  end

  context 'with show page' do
    before do
      visit tasks_path
      click_link I18n.t('task.action.show')
    end

    describe'Link to read a task' do
      it { is_expected.to have_current_path(task_path(task)) }
      it { is_expected.to have_text(I18n.t('task.h1.show_task')) }
      it 'Test back to last page button' do
        click_link I18n.t('task.action.back')
        expect(page).to have_text(I18n.t('task.h1.index_task'))
      end
    end
  end

  context 'with delete the task' do
    before do
      visit tasks_path
    end

    describe 'Successfuly delete a task', driver: :selenium_chrome, js: true do
      it 'Find the delete task'do
        find(:xpath, "//a[@href='/tasks/#{task.id}']", text: I18n.t('task.action.delete')).click
        accept_alert(text: I18n.t('task.message.confirm_delete'), title: task.title)
        expect(page).to have_content(I18n.t('task.message.success_delete'))
        expect(Task.count).to eq(0)
      end
    end
  end
end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'task management', type: :feature do
  subject { page }

  let!(:task) { FactoryBot.create(:task) }

  context 'with new page' do
    before do
      visit tasks_path
      click_link(I18n.t('task.action.create'))
    end

    describe 'Link to creates a new task' do
      it { is_expected.to have_current_path(new_task_path) }
      it { is_expected.to have_css('form') }

      context 'wirh successfuly creates a new task' do
        let(:last_task_fields) { get_fields(Task.last) }
        let(:result_fields) do
          [
            task.title,
            task.content,
            task.start_time,
            task.end_time,
            task.priority,
            task.status
          ]
        end

        before do
          fill_data
          click_button I18n.t('task.action.create')
        end

        it { is_expected.to have_content(task.title) }
        it { is_expected.to have_text(I18n.t('task.message.success_create')) }

        it 'test a task in database' do
          expect(last_task_fields).to eq(result_fields)
        end
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

      def get_fields(task)
        task.attributes.slice('title', 'content', 'start_time', 'end_time', 'priority', 'status').values
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

      context 'with successfuly updates a task' do
        before do
          fill_in 'task_title', with: 'new title'
          click_button(I18n.t('task.action.update'))
        end

        it { is_expected.to have_content('new title') }
        it { is_expected.to have_text(I18n.t('task.message.success_update')) }
      end
    end
  end

  context 'with show page' do
    before do
      visit tasks_path
      click_link I18n.t('task.action.show')
    end

    describe 'Link to read a task' do
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
      context 'with the delete task' do
        before do
          find(:xpath, "//a[@href='/tasks/#{task.id}']", text: I18n.t('task.action.delete')).click
          accept_alert(text: I18n.t('task.message.confirm_delete'), title: task.title)
        end

        it { is_expected.to have_content(I18n.t('task.message.success_delete')) }
      end
    end
  end
end

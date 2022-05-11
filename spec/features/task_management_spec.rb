# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'task management', type: :feature do
  subject { page }

  let!(:task) { create(:task) }

  context 'with new page' do
    before do
      visit tasks_path
      click_link(I18n.t('task.action.create'))
    end

    describe 'Link to creates a new task' do
      it { is_expected.to have_current_path(new_task_path) }
      it { is_expected.to have_css('form') }

      context 'with successfuly creates a new task' do
        let(:last_task_fields) { get_fields(Task.last) }
        let(:result_fields) { get_fields(task) }

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
          find_field('task_state').find('option[selected]').text
        end
      end

      def get_fields(task)
        task.attributes.values_at('title', 'content', 'start_time', 'end_time', 'priority', 'state')
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
          has_css?('#task_list')
        end

        it { is_expected.to have_content(I18n.t('task.message.success_delete')) }
        # it { expect { task.reload }.to raise_error(ActiveRecord::RecordNotFound) }
        it { expect(Task.find_by(id: task.id)).to be_nil }
      end
    end
  end

  context 'with task create order' do
    let!(:new_task) { create(:new_task) }

    describe 'with task list order by create time' do
      before do
        visit tasks_path
      end

      it { is_expected.to have_selector('tr#task_card:nth-child(1)', text: new_task.title) }
      it { is_expected.to have_selector('tr#task_card:nth-child(2)', text: task.title) }
    end
  end

  context 'with task list order by end_time' do
    let!(:new_task) { create(:new_task) }
    let!(:last_task) { create(:last_task) }

    describe 'order by create time' do
      before do
        visit tasks_path
      end

      it { is_expected.to have_selector('tr#task_card:nth-child(1)', text: last_task.title) }
      it { is_expected.to have_selector('tr#task_card:nth-child(2)', text: new_task.title) }
      it { is_expected.to have_selector('tr#task_card:nth-child(3)', text: task.title) }
    end
  end

  context 'when search task by the search field' do
    # Search data
    let!(:new_task) { create(:new_task, title: 'second task', state: 'running') }

    describe 'with task title input content match the output' do
      before do
        visit tasks_path
        within('form') do
          fill_in 'q_title_cont', with: task.title
        end
        click_button I18n.t('task.search_button')
      end

      it { is_expected.to have_content(task.title) }
      it { is_expected.to have_no_content('second task') }
    end

    describe 'with select task state option match output' do
      before do
        visit tasks_path
        page.find_field('q_state_eq').find('option[value="0"]').select_option
        click_button I18n.t('task.search_button')
      end

      it { is_expected.to have_css('#task_card', text: task.title) }
      it { is_expected.not_to have_css('#task_card', text: new_task.title) }

      it 'only have one task to match select' do
        expect(all('#task_card').count).to eq(1)
      end
    end
  end

  describe 'when sort the task' do
    let!(:new_task) { create(:new_task, end_time: Time.zone.at(6.days.from_now.to_i)) }
    let!(:last_task) { create(:last_task, end_time: Time.zone.at(7.days.from_now.to_i)) }

    context 'when sort task by priority asc' do
      before do
        visit tasks_path
        find('#sort_priority', text: I18n.t('task.column.priority')).click
      end

      it {
        expect(subject).to have_selector('tr#task_card:nth-child(1)',
                                         text: I18n.t("task.priority.#{task.priority}"))
      }

      it {
        expect(subject).to have_selector('tr#task_card:nth-child(2)',
                                         text: I18n.t("task.priority.#{new_task.priority}"))
      }

      it {
        expect(subject).to have_selector('tr#task_card:nth-child(3)',
                                         text: I18n.t("task.priority.#{last_task.priority}"))
      }
    end
  end
end

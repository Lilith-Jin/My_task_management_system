# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'with task modle logic' do
    subject { FactoryBot.build(:task, add_attrs) }

    context 'with task validation' do
      let(:add_attrs) { {} }

      it { is_expected.to be_valid }
    end

    context 'when without title' do
      let(:add_attrs) { { title: nil } }

      it { is_expected.not_to be_valid }
    end

    context "with content can't be more than 100 characters" do
      let(:add_attrs) { { content: 'a' * 101 } }

      it { is_expected.not_to be_valid }
    end

    context 'when without a start_time' do
      let(:add_attrs) { { start_time: nil } }

      it { is_expected.not_to be_valid }
    end

    context 'when without a end_time' do
      let(:add_attrs) { { end_time: nil } }

      it { is_expected.not_to be_valid }
    end

    context "with start_time can't be later than end_time" do
      let(:add_attrs) { { start_time: Time.zone.at(5.days.from_now.to_i) } }

      it { is_expected.not_to be_valid }
    end

    context 'when input task_title on search field' do
      it 'with successfuly match the task title' do
        @params = {}
        @params[:q] = { title_cont: 'task' }
        @q = described_class.ransack(@params)
        @tasks = @q.result
        expect(@tasks) == ({ title: 'task' })
      end
    end

    context 'when select the task state on select field' do
      it 'with successfuly match the task state' do
        @params = {}
        @params[:q] = { state_eq: described_class.states }
        @q = described_class.ransack(@params)
        @tasks = @q.result
        expect(@tasks) == ({ state: described_class.states })
      end
    end
  end
end

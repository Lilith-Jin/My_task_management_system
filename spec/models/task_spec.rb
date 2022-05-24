# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'with task modle logic' do
    subject { build(:task, add_attrs) }

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
  end

  describe 'test search condition of task title' do
    # output
    subject(:search) { described_class.ransack(params).result }
    # parameter

    let(:params) { { title_cont: 'task' } }

    context 'when input right task_title on search field' do
      let!(:task) { create(:task, title: 'task') }

      it { is_expected.to eq([task]) }
    end

    context 'when input wrong task_title on search field' do
      let!(:new_task) { create(:new_task, title: 'abc') }

      it { is_expected.not_to eq([new_task]) }
    end
  end

  describe 'test search condition of task state' do
    subject(:search) { described_class.ransack(params).result }

    let!(:params) { { state_eq: 'waiting' } }

    context 'when select title_state on search field to match' do
      let(:task) { create(:task, state: 'waiting') }

      it { is_expected.to eq([task]) }
    end

    context 'when select title_state on search field not to match' do
      let(:new_task) { create(:new_task, state: 'running') }

      it { is_expected.not_to eq([new_task]) }
    end
  end

  describe 'relation of tag' do
    subject { build(:task) }

    it { is_expected.to have_many(:task_tags).class_name('TaskTag') }
    it { is_expected.to have_many(:tags).class_name('Tag') }
  end
end

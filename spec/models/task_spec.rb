# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'with task validation' do
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
  end
end

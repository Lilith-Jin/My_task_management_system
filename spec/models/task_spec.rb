# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'with task validation' do
    subject { FactoryBot.build(:task) }

    context 'with task validation' do
      it 'is valid with valid attributes' do
        subject.start_time = Time.zone.now
        subject.end_time = Time.zone.now + 1
        expect(subject).to be_valid
      end

      it 'is not valid without a title' do
        subject.title = nil
        expect(subject).not_to be_valid
      end

      it 'is not valid without a content' do
        subject.content = nil
        expect(subject).not_to be_valid
      end

      it "with content can't be more than 100 character" do
        subject.content.size > 100
        expect(subject).not_to be_valid
      end

      it 'is not valid without a start_time' do
        subject.start_time = nil
        expect(subject).not_to be_valid
      end

      it 'is not valid without a end_time' do
        subject.end_time = nil
        expect(subject).not_to be_valid
      end

      it "with start_time can't be later than end_time" do
        subject.start_time = Time.zone.now
        subject.end_time = Time.zone.now - 1
        expect(subject).not_to be_valid
      end
    end
  end
end

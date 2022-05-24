# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Tag, type: :model do
  describe 'relation of task' do
    subject { build(:tag) }

    it { is_expected.to have_many(:task_tags).class_name('TaskTag') }
    it { is_expected.to have_many(:tasks).class_name('Task') }
  end

  describe 'validation' do
    subject { build(:tag) }

    it { is_expected.to validate_presence_of(:name) }
  end
end

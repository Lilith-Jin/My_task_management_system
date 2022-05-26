# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TaskTag, type: :model do
  describe 'relation of task' do
    subject { build(:task_tag) }

    it { is_expected.to belong_to(:tag).class_name('Tag') }
    it { is_expected.to belong_to(:task).class_name('Task') }
  end
end

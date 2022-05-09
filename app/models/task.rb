# frozen_string_literal: true

class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, length: { maximum: 100, too_long: ' %{count}s only allow 100 characters ' }, presence: true
  validates_comparison_of :end_time, greater_than: :start_time, other_than: Time.zone.today, allow_nil: false
  validates_comparison_of :start_time, greater_than: Time.zone.today, allow_nil: false

  enum :priority, %i[high mid low], default: :high
  enum :state, %i[waiting running done], default: :waiting
  # enum state: {waiting:0, running:1, done:2}, default: :waiting
end

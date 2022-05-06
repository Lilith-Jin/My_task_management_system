# frozen_string_literal: true

class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, length: { maximum: 100, too_long: ' %{count}s only allow 100 characters ' }, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates_with TaskStartTimeValidator, TaskEndTimeValidator

  enum :priority, %i[high mid low], default: :high
  enum :status, %i[waiting running done], default: :waiting
end

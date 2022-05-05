# frozen_string_literal: true

class Task < ApplicationRecord
  validates :title, presence: true, on: :create
  validates :content, length: { maximum: 100, too_long: ' %{count} only allow 100 characters ' }, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates_with TaskCustomValidator

  enum :priority, %i[high mid low], default: :high
  enum :status, %i[waiting running done], default: :waiting
end

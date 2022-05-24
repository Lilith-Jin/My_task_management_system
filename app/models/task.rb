# frozen_string_literal: true

class Task < ApplicationRecord
  belongs_to :user
  has_many :task_tags
  has_many :tags, through: :task_tags, dependent: :destroy
  validates :title, presence: true
  validates :content, length: { maximum: 100, too_long: ' %<count>s only allow 100 characters ' }, presence: true
  validates_comparison_of :end_time, greater_than: :start_time, other_than: Time.zone.today, allow_nil: false
  validates_comparison_of :start_time, greater_than: Time.zone.today, allow_nil: false
  enum :priority, %i[high mid low], default: :high
  enum :state, %i[waiting running done], default: :waiting

  # for tom-select
  def tags_name
    tags.map(&:name).join(',')
  end

  def tags_name=(strs)
    tags_name = strs.split(',').map(&:strip)
    self.tags = tags_name.map do |name|
      tags.find_or_initialize_by(name: name)
    end
  end
end

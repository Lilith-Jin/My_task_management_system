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
    tags_name = strs.split(',').map { |s| s.strip }
    original_tags_name = tags.map(&:name)
    tags.where.not(name: tags_name).destroy_all
    tags_name.each do |tag_name|
      next if tag_name.in?(original_tags_name)

      tags.build(name: tag_name)
    end
  end
end


# frozen_string_literal: true

class TaskStartTimeValidator < ActiveModel::Validator
  def validate(record)
    time_range_validate(record)
    start_time_validate(record)
  end

  private

  def time_range_validate(record)
    @start_t = record.start_time
    @end_t = record.end_time
    return unless @start_t.present? && @end_t.present? && (@start_t > @end_t)

    record.errors.add :start_time, " can't be later than End time"
  end

  def start_time_validate(record)
    record.errors.add :start_time, " can't be in the past" if @start_t.present? && @start_t < Time.zone.today
  end
end

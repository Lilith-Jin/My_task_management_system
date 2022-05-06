class TaskStartTimeValidator < ActiveModel::Validator
  def validate(record)
    time_range_validate(record)
    start_time_validate(record)
  end

  private
  def time_range_validate(record)
    @start_t = record.start_time
    @end_t = record.end_time

    if @start_t.present? && @end_t.present? && (@start_t > @end_t)
      record.errors.add :start_time, " can't be later than End time"
    end
  end

  def start_time_validate(record)
    if @start_t.present? && @start_t < Time.zone.today
      record.errors.add :start_time, " can't be in the past"
    end
  end
end

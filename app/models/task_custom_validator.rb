class TaskCustomValidator < ActiveModel::Validator
  def validate(record)
    start_time_validate(record)
    time_validate(record)
  end

  def start_time_validate(record)
    @start_t = record.start_time
    @end_t = record.end_time

    if @start_t.present? && @end_t.present? && (@start_t > @end_t)
      record.errors.add :start_time, 'please select the right time'
    end
  end

  def time_validate(record)
    if @start_t.present? && @end_t.present?
      if @start_t < Time.zone.today
        record.errors.add :start_time, "time can't be in the past"
      elsif @end_t < Time.zone.today
        record.errors.add :end_time, "time can't be in the past"
      else
      end
    end
  end
end
class TaskEndTimeValidator < ActiveModel::Validator
	def validate(record)
			end_time_validate(record)
	end
	
	private
	def end_time_validate(record)
		@end_t = record.end_time

		if @end_t.present? && @end_t < Time.zone.today 
			record.errors.add :end_time, " can't be in the past"
		end
	end
end
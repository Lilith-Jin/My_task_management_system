FactoryBot.define do
  factory :task  do
    title { "task1" }
    content { "content1" }
    status { "running" }
    priority {"high"}
    start_time {DateTime.now}
    end_time {DateTime.now + 1.day}
        
      # trait :new_task do
      #   title { 'new_task' }
      #   content { "new_content" }
      # end
  end
end
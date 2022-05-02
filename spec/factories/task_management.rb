FactoryBot.define do
  factory :task do
    title { 'task1' }
    content { 'content1' }
    status { 'running' }
    priority { 'high' }
    start_time { Time.now }
    end_time { Time.now + 1.day }
  end
end
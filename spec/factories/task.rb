# frozen_string_literal: true

FactoryBot.define do
  factory :task do
    title { Faker::Name.name }
    content { Faker::Lorem.paragraph }
    status { 'waiting' }
    priority { 'high' }
    start_time { Time.at((Time.zone.now + 1.day).to_i) }
    end_time { Time.at((Time.zone.now + 3.days).to_i) }
  end

  factory :new_task, class: 'Task' do
    title { Faker::Name.name }
    content { Faker::Lorem.paragraph }
    status { 'waiting' }
    priority { 'high' }
    start_time { Time.at((Time.zone.now + 1.day).to_i) }
    end_time { Time.at((Time.zone.now + 3.days).to_i) }
  end
end

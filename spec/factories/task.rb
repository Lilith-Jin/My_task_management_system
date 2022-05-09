# frozen_string_literal: true

FactoryBot.define do
  factory :task do
    title { Faker::Name.name }
    content { Faker::Lorem.paragraph }
    status { 'waiting' }
    priority { 'high' }
    start_time { Time.zone.at(1.day.from_now.to_i) }
    end_time { Time.zone.at(3.days.from_now.to_i) }
  end

  factory :new_task, class: 'Task' do
    title { Faker::Name.name }
    content { Faker::Lorem.paragraph }
    status { 'waiting' }
    priority { 'high' }
    start_time { Time.zone.at(1.day.from_now.to_i) }
    end_time { Time.zone.at(3.days.from_now.to_i) }
  end
end

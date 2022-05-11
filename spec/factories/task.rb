# frozen_string_literal: true

FactoryBot.define do
  factory :task do
    title { Faker::Name.name }
    content { Faker::Lorem.paragraph }
    state { 'waiting' }
    priority { 'high' }
    start_time { Time.zone.at(1.day.from_now.to_i) }
    end_time { Time.zone.at(5.days.from_now.to_i) }
  end

  factory :new_task, class: 'Task' do
    title { Faker::Name.name }
    content { Faker::Lorem.paragraph }
    state { 'running' }
    priority { 'mid' }
    start_time { Time.zone.at(1.day.from_now.to_i) }
    end_time { Time.zone.at(3.days.from_now.to_i) }
  end

  factory :last_task, class: 'Task' do
    title { Faker::Name.name }
    content { Faker::Lorem.paragraph }
    state { 'running' }
    priority { 'low' }
    start_time { Time.zone.at(1.day.from_now.to_i) }
    end_time { Time.zone.at(2.days.from_now.to_i) }
  end
end

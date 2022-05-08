# frozen_string_literal: true

FactoryBot.define do
  factory :task do
    title { Faker::Name.name }
    content { Faker::Lorem.paragraph }
    state { 'waiting' }
    priority { 'high' }
    start_time { Time.at((Time.zone.now + 1.day).to_i) }
    end_time { Time.at((Time.zone.now + 5.days).to_i) }
  end

  factory :new_task, class: 'Task' do
    title { Faker::Name.name }
    content { Faker::Lorem.paragraph }
    state { 'waiting' }
    priority { 'high' }
    start_time { Time.at((Time.zone.now + 1.day).to_i) }
    end_time { Time.at((Time.zone.now + 3.day).to_i) }
  end

  factory :last_task, class: 'Task' do
    title { Faker::Name.name }
    content { Faker::Lorem.paragraph }
    state { 'waiting' }
    priority { 'high' }
    start_time { Time.at((Time.zone.now + 1.day).to_i) }
    end_time { Time.at((Time.zone.now + 2.day).to_i) }
  end
end

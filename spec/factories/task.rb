# frozen_string_literal: true

FactoryBot.define do
  factory :task do
    title { Faker::Name.name }
    content { Faker::Lorem.paragraph }
    status { 'waiting' }
    priority { 'high' }
    start_time { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now, format: :short) }
    end_time { Faker::Time.forward(days: 7, format: :short) }
  end
end

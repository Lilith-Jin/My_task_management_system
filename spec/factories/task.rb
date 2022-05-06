# frozen_string_literal: true

FactoryBot.define do
  factory :task do
    title { Faker::Name.name }
    content { Faker::Lorem.paragraph }
    status { 'waiting' }
    priority { 'high' }
    start_time { Faker::Time.between(from: DateTime.now + 1.day, to: DateTime.now + 2.days, format: :short) }
    end_time { Faker::Time.between(from: DateTime.now + 3.days, to: DateTime.now + 5.days, format: :short) }
    # start_time { Faker::Time.between(from: Time.zone.today + 1.day, to: Time.zone.today + 2.days, format: :short) }
    # end_time { Faker::Time.between(from: Time.zone.today + 3.days, to: Time.zone.today + 5.days, format: :short) }
  end
end

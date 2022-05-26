# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { 'user@example.com' }
    password { 'password' }
    password_confirmation { 'password' }
    role { 'admin' }
  end
end

# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    first_name { 'first name' }
    last_name { 'last name' }
    sequence(:email) { |n| "email#{n}@example.com" }
    password { '123456a' }
    password_confirmation { '123456a' }
    confirmed_at { Time.current }
  end
end

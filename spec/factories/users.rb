# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    first_name { 'first name' }
    last_name { 'last name' }
    sequence(:email) { |n| "email#{n}@example.com" }
    sequence(:password) { |n| "123456#{n}" }
    confirmed_at { Time.current }
  end
end

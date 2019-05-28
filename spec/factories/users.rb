# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    first_name { 'first name' }
    last_name { 'last name' }
    sequence(:email) { |n| "email#{n}@example.com" }
    sequence(:password) { |n| "123456#{n}" }
    confirmed_at { Time.current }

    trait :student do
      roles { [Role.where(name: 'student').first_or_create] }
    end
    trait :admin do
      roles { [Role.where(name: 'admin').first_or_create] }
    end
  end
end

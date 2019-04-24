# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    first_name { 'first name' }
    last_name { 'last name' }
    sequence(:email) { |n| "email#{n}@example.com" }
    password { '1234567' }
    password_confirmation { '1234567' }
    avatar { Rack::Test::UploadedFile.new(Rails.root.join('spec/test1.jpg')) }
    confirmed_at { Time.current }
  end
end

# frozen_string_literal: true

FactoryBot.define do
  factory :email_change_request do
    sequence(:email) { |n| "email#{n}@example.com" }
    token { SecureRandom.uuid }
    user
  end
end

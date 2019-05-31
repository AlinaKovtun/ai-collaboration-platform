# frozen_string_literal: true

FactoryBot.define do
  factory :task do
    sequence(:title) { |n| "Event #{n}" }
    short_information { 'description text' }
    created_at { Time.now + 1.week }
  end
end

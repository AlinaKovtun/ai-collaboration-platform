# frozen_string_literal: true

FactoryBot.define do
  factory :event do
    sequence(:title) { |n| "Event #{n}" }
    description { 'description text' }
    event_start { Time.now + 1.week }
    event_end { Time.now + 1.week + 2.hours }
    cost { 0 }
    venue { 'Lviv' }
    trait :draft do
      state { 'draft' }
    end
    trait :sheduled do
      state { 'sheduled' }
    end
    user
  end
end

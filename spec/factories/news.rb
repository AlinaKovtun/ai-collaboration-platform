# frozen_string_literal: true

FactoryBot.define do
  factory :news do
    sequence(:title) { |n| "Title #{n}" }
    body { 'body' }
    short_information { 'short_information' }
    category

    trait :draft do
      state { 'draft' }
    end
    trait :published do
      state { 'published' }
    end
    user
  end
end

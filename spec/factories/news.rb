# frozen_string_literal: true

FactoryBot.define do
  factory :news do
    sequence(:title) { |n| "Title #{n}" }
    body { 'body' }
    short_information { 'short_information' }
    category
    user
  end
end

# frozen_string_literal: true

FactoryBot.define do
  factory :category do
    sequence(:name) { |n| "Mycategory #{n}" }
    description { 'MyCategory Description' }
  end
end

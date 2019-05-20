# frozen_string_literal: true

FactoryBot.define do
  factory :project do
    name { 'Project name' }
    description { 'Project name' }
    association :author, factory: :user
  end
end

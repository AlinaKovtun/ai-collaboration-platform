# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    content { Faker::Lorem.paragraph(5) }
    association :commentable, factory: :news
    user
  end
end

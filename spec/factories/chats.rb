# frozen_string_literal: true

FactoryBot.define do
  factory :chat do
    body { Faker::Lorem.paragraph(2) }
    created_at { '2019-05-24 20:30:33' }
    user
  end
end

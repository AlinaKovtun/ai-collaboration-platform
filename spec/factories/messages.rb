# frozen_string_literal: true

FactoryBot.define do
  factory :message do
    author_name { 'Author name' }
    email { 'example@email.com' }
    body { 'Body' }
  end
end

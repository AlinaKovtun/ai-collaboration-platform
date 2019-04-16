# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    first_name { 'first name' }
    last_name { 'last name' }
    email { 'email@gmail.com' }
    password { '123456a' }
    description { '' }
  end
end

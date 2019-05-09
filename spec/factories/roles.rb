# frozen_string_literal: true

FactoryBot.define do
  factory :role do
    name { 'role' }

    factory %w[admin student menthor teacher expert].each do |role_name|
      name { role_name }
    end
  end
end

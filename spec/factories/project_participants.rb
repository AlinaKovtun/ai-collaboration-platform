# frozen_string_literal: true

FactoryBot.define do
  factory :project_participant do
    user
    role
    project
  end
end

# frozen_string_literal: true

FactoryBot.define do
  factory :role, class: 'Role' do
    name { 'role' }

    %w[admin student mentor teacher expert].each do |role_name|
      factory "#{role_name}_role" do
        name { role_name }
      end
    end
  end
end

# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database
# with its default values. The data can then be loaded with the rails db:seed
# command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

%w[student expert menthor teacher admin].each do |role|
  Role.create!(name: role)
end
u = User.create!(first_name: 'Dark',
                 last_name: 'Side',
                 email: ENV['GMAIL_USERNAME'],
                 password: ENV['GMAIL_PASSWORD']).confirm
u.roles << Role.find_by_name('admin')

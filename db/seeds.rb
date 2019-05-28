# frozen_string_literal: true

require 'faker'

%w[student expert mentor teacher admin].each do |role|
  Role.create!(name: role)
end
User.create!(first_name: 'Dark',
             last_name: 'Side',
             email: ENV['GMAIL_USERNAME'],
             password: ENV['GMAIL_PASSWORD']).confirm
u = User.last
u.roles << Role.last

10.times do |n|
  User.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    role_ids: Role.all.pluck(:id).sample,
    email: (n.to_s + Faker::Internet.email),
    password: Faker::Config.random = Random.new(10),
    confirmed_at: Time.now,
    approved: true
  ).skip_confirmation!
end

8.times do |n|
  Category.create(
    name: (Faker::Game.genre + n.to_s),
    description: Faker::Books::Lovecraft.paragraph
  )
end

10.times do |n|
  News.create(
    title: (Faker::Book.title + n.to_s),
    short_information: Faker::Books::Lovecraft.paragraph,
    user_id: User.all.pluck(:id).sample,
    body: Faker::Books::Lovecraft.paragraph,
    category_id: Category.all.pluck(:id).sample
  )
end

10.times do |n|
  Event.create(
    title: (Faker::Book.title + n.to_s),
    description: Faker::Books::Lovecraft.paragraph,
    event_start: (Time.now + 1.day),
    event_end: (Time.now + 2 * n.day),
    venue: Faker::Games::LeagueOfLegends.location,
    user_id: User.all.pluck(:id).sample
  )
end

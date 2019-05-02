# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.2'

gem 'bootsnap', '>= 1.1.0', require: false
gem 'bootstrap', '~> 4.3.1'
gem 'coffee-rails', '~> 4.2'
gem 'devise'
gem 'devise-async'
gem 'faker', git: 'https://github.com/stympy/faker.git', branch: 'master'
gem 'font-awesome-rails'
gem 'font-awesome-sass'
gem 'haml'
gem 'jbuilder', '~> 2.5'
gem 'jquery-rails'
gem 'material-sass', '4.1.1'
gem 'pg'
gem 'rails', '~> 5.2.3'
gem 'rails-i18n'
gem 'redis', '~> 4.0'
gem 'redis-namespace'
gem 'rubocop'
gem 'sass-rails', '~> 5.0'
gem 'sidekiq'
gem 'tinymce-rails'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'rspec-rails', '~> 3.8'
end

group :development do
  gem 'haml-rails', '~> 2.0'
  gem 'letter_opener'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'octokit'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'rails-controller-testing'
  gem 'rspec_junit_formatter'
  gem 'shoulda-matchers'
  gem 'simplecov', require: false
  gem 'simplecov-json', require: false
end

group :production do
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

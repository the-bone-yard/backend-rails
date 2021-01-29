# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

ruby '2.6.6'

gem 'bcrypt'
gem 'bootsnap'
gem 'coffee-rails', '~> 4.2'
gem 'faraday'
gem 'fast_jsonapi'
gem 'figaro'
gem 'jbuilder', '~> 2.5'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.7'
gem 'rails', '5.2.4.3'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'rack-cors'

group :development, :test do
  gem 'pry'
  gem 'travis'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'rubocop-rails'
  gem 'rubocop-rspec'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'capybara'
  gem 'launchy'
  gem 'rspec-rails'
  gem 'shoulda-matchers'
  gem 'simplecov'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

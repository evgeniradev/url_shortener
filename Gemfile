# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.3'

gem 'active_model_serializers', '~> 0.10.12'
gem 'bootsnap', '>= 1.4.4', require: false
gem 'devise', '~> 4.8'
gem 'haml', '~> 5.2', '>= 5.2.1'
gem 'jbuilder', '~> 2.7'
gem 'puma', '~> 5.0'
gem 'rails', '~> 6.1.3', '>= 6.1.3.2'
# need to specify sassc version due to a problem with Docker
gem 'sassc', '2.1.0'
gem 'sass-rails', '>= 6'
gem 'sqlite3', '~> 1.4'
gem 'turbolinks', '~> 5'
gem 'webpacker', '~> 5.0'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
end

group :development do
  gem 'listen', '~> 3.3'
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'spring'
  gem 'web-console', '>= 4.1.0'
end

group :test do
  gem 'apparition', '~> 0.6.0'
  gem 'capybara', '~> 3.35', '>= 3.35.3'
  gem 'capybara-screenshot', '~> 1.0', '>= 1.0.25'
  gem 'database_cleaner-active_record', '~> 2.0', '>= 2.0.1'
  gem 'factory_bot_rails', '~> 6.2'
  gem 'ffaker', '~> 2.18'
  gem 'rspec-rails', '~> 5.0', '>= 5.0.1'
  gem 'rubocop', '~> 1.17'
  gem 'rubocop-rails', '~> 2.11'
  gem 'rubocop-rspec', '~> 2.4'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.3'

gem 'dotenv-rails' , groups: %i[development test]

gem 'rails', '~> 5.2.2'
gem 'puma', '~> 3.11'
gem 'pg', '>= 0.18', '< 2.0'

# Background processing
gem 'sidekiq', '~> 5.1.3'
gem 'sidekiq-status'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

# Settings
gem 'config'

group :development, :test do
  gem 'database_cleaner'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'rspec-rails', '~> 3.8'
  gem 'pry-rails'
end

group :development do
  gem 'annotate', require: false
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'rspec-its'
  gem 'shoulda-matchers'
  gem 'simplecov', require: false
end

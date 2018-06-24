source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.7'
gem 'rails', '~> 5.1.6'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'

gem 'jbuilder', '~> 2.5'

gem 'bcrypt', '~> 3.1.11'
gem 'devise', '~> 4.4.3'

gem 'kaminari'
gem 'kaminari-core', '~> 1.1.1'

gem 'commonmarker'

gem 'exception_notification'
gem 'sendgrid-ruby'

group :development, :test do
  gem 'capybara', '~> 2.13'
  gem 'pry'
  gem 'rspec-rails'
  gem 'rubocop', '= 0.57.2', require: false
  gem 'selenium-webdriver'
end

group :development do
  gem 'capistrano', '~> 3.10', require: false
  gem 'capistrano-bundler', '~> 1.3', require: false
  gem 'capistrano-rails', '~> 1.3', require: false
  gem 'capistrano-rvm', require: false
  gem 'listen', '>= 3.0.5', '< 3.2'
end

ruby '2.5.1'

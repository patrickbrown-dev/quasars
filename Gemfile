source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'nokogiri', '>= 1.8.5'
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
  gem 'codecov', require: false
  gem 'factory_bot_rails'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'pry'
  gem 'rails-controller-testing'
  gem 'rspec-rails'
  gem 'rubocop', '~> 0.61.1', require: false
  gem 'rubocop-rspec', require: false
  gem 'selenium-webdriver'
  gem 'timecop'
end

ruby '2.6.0'

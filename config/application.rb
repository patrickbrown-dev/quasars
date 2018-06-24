require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module App
  class Application < Rails::Application
    config.generators.javascript_engine = :js
    config.generators.test_framework = :rspec
    config.load_defaults 5.1
  end
end

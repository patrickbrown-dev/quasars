require_relative 'config/application'

Rails.application.load_tasks

if Rails.env.development? || Rails.env.test?
  require 'rubocop/rake_task'

  RuboCop::RakeTask.new

  task default: [:spec, :rubocop]
end

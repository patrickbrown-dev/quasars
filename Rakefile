require_relative 'config/application'
require 'rubocop/rake_task'

Rails.application.load_tasks
RuboCop::RakeTask.new

task default: %i[spec rubocop]

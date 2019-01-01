threads_count = ENV.fetch('RAILS_MAX_THREADS') { 5 }
threads threads_count, threads_count

port        ENV.fetch('PORT') { 3000 }

environment ENV.fetch('RAILS_ENV') { 'development' }

# bind 'unix:///var/run/puma.sock' if ENV['RAILS_ENV'] == 'production'

plugin :tmp_restart

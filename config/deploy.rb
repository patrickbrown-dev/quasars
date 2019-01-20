lock '~> 3.11.0'

set :application, 'quasars'
set :repo_url, 'https://github.com/kineticdial/quasars.git'
set :rvm_type, :system
set :rvm_custom_path, '/usr/share/rvm'

namespace :deploy do
  task :restart_quasars do
    on roles(:all) do |_host|
      execute 'service quasars restart'
    end
  end

  # TODO: Not working
  # task :floating_ip do
  #   if `curl https://quasa.rs/healthcheck`.include?('green')
  #     `RAILS_ENV=development rake digital_ocean:floating_ip['blue']`
  #   else
  #     `RAILS_ENV=development rake digital_ocean:floating_ip['green']`
  #   end
  # end
end

after 'deploy:symlink:release', 'deploy:restart_quasars'
# after 'deploy:restart_quasars', 'deploy:floating_ip'

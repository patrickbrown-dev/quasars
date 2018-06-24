lock '~> 3.10.2'

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
end

after 'deploy:symlink:release', 'deploy:restart_quasars'

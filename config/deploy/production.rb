if `curl https://quasa.rs/healthcheck`.include?('green')
  set :deploy_target, 'blue'
else
  set :deploy_target, 'green'
end

set :stage, 'production'
server "#{fetch(:deploy_target)}.quasa.rs", user: 'root', roles: %w[app web]

set :branch do
  default_tag = `git tag`.split("\n").last
  ask(:tag, default_tag)
  fetch(:tag)
end

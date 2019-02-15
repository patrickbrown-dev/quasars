set :stage, 'production'

server '167.99.104.17', user: 'root', roles: %w[app web]
server '167.99.172.20', user: 'root', roles: %w[app web]

set :branch do
  default_tag = `git tag`.split("\n").last
  ask(:tag, default_tag)
  fetch(:tag)
end

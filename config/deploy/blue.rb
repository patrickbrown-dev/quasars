set :stage, 'production'
server 'blue.quasa.rs', user: 'root', roles: %w[app web]

set :branch do
  default_tag = `git tag`.split("\n").last
  ask(:tag, default_tag)
  fetch(:tag)
end

# server "db.quasa.rs", user: "root", roles: %w{db}

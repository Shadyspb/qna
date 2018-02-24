# server-based syntax
# ======================
# Defines a single server with a list of roles and multiple properties.
# You can define all roles on a single server, or split them:

server "95.213.204.148", user: "deployer", roles: %w{app db web}, primary: true
# server "example.com", user: "deploy", roles: %w{app web}, other_property: :other_value
# server "db.example.com", user: "deploy", roles: %w{db}

role :app, %w{deployer@95.213.204.148}
role :web, %w{deployer@95.213.204.148}
role :db,  %w{deployer@95.213.204.148}

set :rails_env, :production


set :ssh_options, {
  keys: %w(/home/shady/.ssh/id_rsa),
  forward_agent: true,
  auth_methods: %w(publickey password),
  port: 4321
}

# config valid for current version and patch releases of Capistrano
lock "~> 3.10.1"

set :application, "qna"
set :repo_url, "git@github.com:Shadyspb/qna.git"

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/home/deployer/qna"
set :deployer_user, 'deployer'


# Default value for :linked_files is []
set :linked_files, %w{config/database.yml config/private_pub.yml .env}

# Default value for linked_dirs is []
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}


namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart
end

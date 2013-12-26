set :application, 'app_name'
set :repo_url, "git@git-server:user/path-to-app.git"
set :user, 'webuser'
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }
set :branch, 'master'

set :deploy_to, "/home/#{fetch(:user)}/apps/#{fetch(:application)}"
set :scm, :git

# set :format, :pretty
# set :log_level, :debug
# set :pty, true

set :linked_files, %w{config/database.yml config/app_config.yml config/unicorn.rb config/nginx.conf config/newrelic.yml}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# set :default_env, { path: "/opt/ruby/bin:$PATH" }
set :keep_releases, 5

set :unicorn_config, "#{current_path}/config/unicorn.rb"
set :unicorn_pid, "#{current_path}/tmp/pids/unicorn.pid"

namespace :deploy do
  desc "Start unicorn"
  task :start do
    on roles(:app), in: :sequence, wait: 5 do
      within current_path do
        execute :bundle, "exec", "unicorn_rails -c #{fetch(:unicorn_config)} -E #{fetch(:rails_env)} -D"
      end
    end
  end

  desc "Stop unicorn"
  task :stop do
    on roles(:app), in: :sequence, wait: 5 do
      if test("[ -f #{fetch(:unicorn_pid)} ]")
        execute :kill, "-QUIT", "`cat #{fetch(:unicorn_pid)}`"
      end
    end
  end

  desc "Restart unicorn"
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      if test("[ -f #{fetch(:unicorn_pid)} ]")
        execute :kill, "-USR2", "`cat #{fetch(:unicorn_pid)}`"
      end
    end
  end
  
  task :query_interactive do
    on roles(:app) do
      info capture("[[ $- == *i* ]] && echo 'Interactive' || echo 'Not interactive'")
    end
  end

  task :query_login do
    on roles(:app) do
      info capture("shopt -q login_shell && echo 'Login shell' || echo 'Not login shell'")
    end
  end

  task :query_path do
    on roles(:app) do
      info capture("echo $PATH")
    end
  end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      within release_path do
        execute :rake, 'cache:clear'
      end
    end
  end

  after :finishing, 'deploy:cleanup'

end

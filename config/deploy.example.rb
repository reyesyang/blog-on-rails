# -*- encoding : utf-8 -*-
set :user, "your"
set :application, "blog"

# If you use rvm, please uncomment the following 4 lines
# require "rvm/capistrano"                  # Load RVM's capistrano plugin.
# set :rvm_path, "/home/#{user}/.rvm"
# set :rvm_bin_path, "/home/#{user}/.rvm/bin"        # Or whatever env you want it to run in.

set :scm_username, "git"
set :domain, "your"
set :repository,  "your"
# set :repository,  "#{scm_username}@#{domain}:#{application}.git"

set :scm, :git
set :branch, :master
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`
set :deploy_to, "/home/#{user}/apps/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false

set :unicorn_config, "#{current_path}/config/unicorn.rb"
set :unicorn_pid, "#{current_path}/tmp/pids/unicorn.pid"

role :web, domain                          # Your HTTP server, Apache/etc
role :app, domain                          # This may be the same as your `Web` server
role :db,  domain, :primary => true        # This is where Rails migrations will run
# role :db,  "your slave db-server here"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  desc "Start unicorn"
  task :start do
    run "cd #{current_path} && RAILS_ENV=production bundle exec unicorn_rails -c #{unicorn_config} -D"
  end

  desc "Stop unicorn"
  task :stop do
    run "if [ -f #{unicorn_pid} ]; then kill -QUIT `cat #{unicorn_pid}`; fi"
  end

  desc "Restart unicorn"
  task :restart do
    run "if [ -f #{unicorn_pid} ]; then kill -s USR2 `cat #{unicorn_pid}`; fi"
  end

  desc "Reload the database with seed data"
  task :seed do
    run "cd #{current_path}; rake db:seed RAILS_ENV=production"
  end
  task :do do
    run "echo $PATH"
  end
end

after "deploy:update_code" do
  run "cp #{deploy_to}/shared/config/*.yml #{release_path}/config" # So we need cp config files to share config folder manually first
  run "cd #{release_path} && bundle install"
  run "cd #{release_path}; RAILS_ENV=production rake assets:precompile"
  sudo "ln -nfs #{current_path}/config/nginx.conf /etc/nginx/sites-enabled/#{application}"
end


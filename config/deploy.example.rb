# -*- encoding : utf-8 -*-
set :user, "your"
set :application, "your"

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
set :deploy_to, "/home/#{user}/projects/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false

role :web, domain                          # Your HTTP server, Apache/etc
role :app, domain                          # This may be the same as your `Web` server
role :db,  domain, :primary => true        # This is where Rails migrations will run
# role :db,  "your slave db-server here"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  desc "Cause Passenger to initiate a restart"
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
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
end


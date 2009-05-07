load 'deploy' if respond_to?(:namespace) # cap2 differentiator

default_run_options[:pty] = true

# be sure to change these
set :user, 'peterszinek'
set :domain, 'suggestions.rubychallenge.com'
set :application, 'rubychallenge-suggestions'

# the rest should be good
set :repository,  "git@github.com:hexagile/hf-gui-tracker.git" 
set :deploy_to, "/home/#{user}/#{domain}" 
set :deploy_via, :remote_cache
set :scm, 'git'
set :branch, 'master'
set :git_shallow_clone, 1
set :scm_verbose, true
set :use_sudo, false

server domain, :app, :web

namespace :deploy do
  task :restart do
    run "touch #{current_path}/tmp/restart.txt" 
		run "cp #{current_path}/config/production_config.yaml #{current_path}/config/config.yaml"
  end
end
# frozen_string_literal: true

lock '~> 3.10.1'

set :application,     'project'
set :user,            'deploy'
set :deploy_to,       "/home/#{fetch(:user)}/#{fetch(:application)}"
set :repo_url,        'git@github.com:Zawgor24/Project.git'

set :passenger_restart_with_touch, true

append :linked_files, 'config/database.yml', 'config/secrets.yml'
append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets',
  'vendor/bundle', 'public/system', 'public/uploads'

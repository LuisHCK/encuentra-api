set :repo_url, "git@github.com:LuisHCK/encuentra-api.git"
set :application, "encontracuarto"
set :user, "encontracuarto"

# Don't change these unless you know what you're doing
set :pty, true
set :use_sudo, false
set :deploy_via, :remote_cache
set :deploy_to, "/var/www/#{fetch(:application)}"
set :ssh_options, {forward_agent: true, user: fetch(:user), keys: %w(~/.ssh/id_rsa.pub)}

## Defaults:
# set :scm,           :git
# set :branch,        :core
# set :format,        :pretty
# set :log_level,     :debug
set :keep_releases, 3

set :assets_roles, []

## Linked Files & Directories (Default None):
set :linked_dirs, %w{public/uploads}

# set :linked_files, %w{config/database.yml}
# set :linked_dirs,  %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

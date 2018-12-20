server "167.99.100.205", port: 22, roles: [:web, :app, :db], primary: true
set :stage, :production
set :branch, :master

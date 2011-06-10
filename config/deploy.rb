require 'bundler/capistrano'

set :application, "webstore_app"
set :repository,  "git://github.com/renuy/webstore_app.git"

set :scm, :git

set :deploy_to, "/disk1/webstore_app"
set :user, 'rails'
set :scm_username, 'akil_rails'
set :use_sudo, false

# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "74.86.131.195"                          # Your HTTP server, Apache/etc
role :app, "74.86.131.195"                          # This may be the same as your `Web` server
role :db,  "74.86.131.195", :primary => true # This is where Rails migrations will run
# role :db,  "74.86.131.195"

# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts
  namespace :deploy do
    task :copy_database_configuration do 
      production_db_config = "/disk1/webstore_app/database.yml" 
      run "cp #{production_db_config} #{release_path}/config/database.yml"
    end
    after "deploy:update_code", "deploy:copy_database_configuration"
  end


  namespace :deploy do
    task :copy_mail_configuration do 
      production_mail_config = "/disk1/webstore_app/setup_mail.rb" 
      run "cp #{production_mail_config} #{release_path}/config/initializers/setup_mail.rb"
    end
    after "deploy:update_code", "deploy:copy_mail_configuration"
  end

 namespace :deploy do
   task :start do ; end
   task :stop do ; end
   task :restart, :roles => :app, :except => { :no_release => true } do
     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
   end
 end
 

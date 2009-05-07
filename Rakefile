require 'rubygems'
require 'activerecord'    
   
task :default => :migrate  
   
desc "Migrate the database through scripts in db/migrate. Target specific version with VERSION=x"  
task :migrate => :environment do   
  ver = ENV["VERSION"] ? ENV["VERSION"].to_i : nil   
  ActiveRecord::Migrator.migrate('db/migrate', ver)  
end  

task :environment do                                                                 
  config = YAML::load(open('config/config.yaml'))
  SINATRA_ENV = config[:env] unless(defined?(SINATRA_ENV)) 

  db_settings = YAML::load(open('config/database.yaml'))[SINATRA_ENV]
  ActiveRecord::Base.establish_connection(db_settings)
  ActiveRecord::Base.logger = Logger.new(File.open('database.log', 'a'))  
end
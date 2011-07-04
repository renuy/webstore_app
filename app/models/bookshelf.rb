
class Bookshelf < ActiveRecord::Base

establish_connection Rails.configuration.database_configuration["memp_db"] 
end

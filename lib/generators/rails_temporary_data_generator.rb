require 'rails/generators'
require 'rails/generators/migration'

class RailsTemporaryDataGenerator < Rails::Generators::Base
  include Rails::Generators::Migration
  
  def create_migration_file
    migration_template 'migration.rb', 'db/migrate/create_temporary_data.rb'
  end
  
end
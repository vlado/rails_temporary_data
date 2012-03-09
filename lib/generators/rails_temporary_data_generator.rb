class RailsTemporaryDataGenerator < Rails::Generators::Base
  
  def create_migration_file
    migration_template 'migration.rb', 'db/migrate/create_temporary_data.rb'
  end
  
end
namespace :rails_temporary_data do
  
  desc "Removes expired entries from temporary data table"
  task :delete_expired => :environment do
    TemporaryData.delete_expired
  end
  
end
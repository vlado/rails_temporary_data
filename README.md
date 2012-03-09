RailsTemporaryData
==================

Rails engine to simply save temporary data that is too big for session in database

Install
-------

Start by adding the gem to your application's Gemfile

    gem 'rails_temporary_data', :git => 'git://github.com/vlado/rails_temporary_data.git'

Update your bundle

    bundle install
    
Generate migration

    rails generate rails_temporary_data
  
Run migration

    rake db:migrate
    
Example
-------

Coming soon


TODO
----

* Tests
* Rake task to remove expired data
* Controller helpers
* Publish gem
* Default expires_at as configuration option
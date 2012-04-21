RailsTemporaryData
==================

Rails engine to simply save big temporary data (too big for session cookie store) in a database. It is great for a step-by-step wizard or similar functionality.

Why
---
While working on [Padbase](http://www.padbase.com) we needed [2 steps signup process](http://www.padbase.com/pads/new) (1. enter property info, 2. enter user info). Info entered in first step could get very large and we couldn't save it in a session because of [CookieOverflow](http://api.rubyonrails.org/classes/ActionDispatch/Cookies/CookieOverflow.html), didn't want to switch to ActiveRecord store and didn't want to save invalid property in database with the flag (partial validations, ...). Solution was to create separate table for this temporary data and RailsTemporaryData was born.
**This way you get best from both worlds. Standard session data is still saved in a cookie and you can save larger amount of data in a database.**

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
--------

  class DummyController < ApplicationController

    def set_data
      set_tmp_data("some_key", { first_name: "Vlado", last_name: "Cingel", bio: "Very ... very long bio" })
      ...
    end

    def get_data
      tmp_data = get_tmp_data("some_key").data
      # do something with tmp data
      first_name = tmp_data[:first_name] # => Vlado
      ...
    end

  end

You can optionally set data expiry time (default is 2 days)

  class DummyController < ApplicationController

    def set_data
      set_tmp_data("some_key", { first_name: "Vlado", last_name: "Cingel", bio: "Very ... very long bio" }, Time.now + 3.days)
      ...
    end

  end

To clear data you don't need any more

  class DummyController < ApplicationController

    def get_data
      tmp_data = get_tmp_data("some_key").data
      # do something with tmp data
      clear_tmp_data("some_key")
    end

  end

To help you clear unwanted and/or expired data rake task is provided. You should set a cron job to call this task daily.

  rake rails_temporary_data:delete_expired


TODO
----

* Publish gem
* Default expires_at as configuration option
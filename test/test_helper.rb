ENV["RAILS_ENV"] = "test"
require 'dummy_rails_app/config/environment'
require 'rails/test_help'

Bundler.setup

ActiveRecord::Migrator.migrate(File.expand_path("../dummy_rails_app/db/migrate/", __FILE__))

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

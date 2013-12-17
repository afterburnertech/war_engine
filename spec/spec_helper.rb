# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../dummy/config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'capybara/rspec'
require 'factory_girl'
require 'database_cleaner'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[File.dirname(__FILE__) + "/support/**/*.rb"].each {|f| require f}

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

RSpec.configure do |config|
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  #config.use_transactional_fixtures = true
  # using database_cleaner

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"

  # Inside the before(:all) block, we’re setting up 
  # the Database Cleaner gem’s strategy to be truncation, 
  # so that the tables are all truncated at the end of each test, 
  # rather than having the tests run inside a transaction. 
  # The pre_count option will perform counts on the tables 
  # database cleaner wants to truncate, and if there’s any records
  # in them will truncate them, leaving the empty tables alone. 
  # The reset_ids option will reset the auto-increment count on 
  # each of the tables.
  config.before(:all) do
    DatabaseCleaner.strategy = :truncation,
      {:pre_count => true, :reset_ids => true} 
    DatabaseCleaner.clean_with(:truncation)
  end 
  config.before(:each) do
    DatabaseCleaner.start 
  end
  config.after(:each) do 
    Apartment::Database.reset 
    DatabaseCleaner.clean
  end


  # Ensure that the database state is reset after each test
  config.after(:each) do 
    Apartment::Database.reset
    connection = ActiveRecord::Base.connection.raw_connection
    schemas = connection.query(%Q{
      SELECT 'drop schema ' || nspname || ' cascade;'
      from pg_namespace
      where nspname != 'public'
      AND nspname NOT LIKE 'pg_%'
      AND nspname != 'information_schema';
    })
    schemas.each do |query| 
      connection.query(query.values.first)
    end
  end

  # Requests to the root path for the application now will go to a faux
  # http://example.com, rather than http://www.example.com  
  Capybara.app_host = "http://example.com"
end

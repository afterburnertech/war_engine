# Why is this require here?
# We could put the require for Warden within the
# file at lib/war_engine.rb, but due to how the 
# engine is loaded by Rake tasks, that file is not
# required at all. This means that any require 
# statements within that file would not be executed.
# Placing it within lib/war_engine/engine.rb will
# make it work for our test purposes, when we use 
# the engine inside an application, and when we 
# want to run Rake tasks on the engine itself.

require 'warden'
require 'dynamic_form'
module WarEngine
  class Engine < ::Rails::Engine
    isolate_namespace WarEngine

    config.generators do |g|
    	g.test_framework :rspec, :view_specs => false 
    end

    # insert the Warden::Manager middleware into the application’s middleware stack
    initializer 'subscribem.middleware.warden' do 
    	Rails.application.config.middleware.use Warden::Manager do |manager| 
    		# this strategy is defined in config/initializers/warden/strategies/password.rb
    		manager.default_strategies :password
		end
    end
  end
end

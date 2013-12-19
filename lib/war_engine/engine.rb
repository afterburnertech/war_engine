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
require 'apartment'
require 'braintree'

module WarEngine
    class Engine < ::Rails::Engine
        isolate_namespace WarEngine

        config.generators do |g|
        	g.test_framework :rspec, :view_specs => false 
        end

        # insert the Warden::Manager middleware into the application’s middleware stack
        initializer 'war_engine.middleware.warden' do 
        	Rails.application.config.middleware.use Warden::Manager do |manager| 
        		# this strategy is defined in config/initializers/warden/strategies/password.rb
        		manager.default_strategies :password
    		end
        end

        

        # Methods will no longer be available within controllers that
        # sub- class WarEngine::ApplicationController – that is, all
        # controllers within the engine – because 
        # WarEngine::ApplicationController inherits directly from 
        # ActionController::Base. These methods now live in 
        # ApplicationController, by way of an extender.
        # The to_prepare block here will run every time a new request
        # happens under the development environment, and only once 
        # (while the server is starting up) in the production 
        # environment
        config.to_prepare do
    	    root = WarEngine::Engine.root
    	    extenders_path = root + "app/extenders/**/*.rb" 
    	    Dir.glob(extenders_path) do |file|
    		    Rails.configuration.cache_classes ? require(file) : load(file) 
    		end
        end

        

        # Check the subdomain for the request and then 
        # switch the schema lookup path to include the 
        # schema which has the same name as the subdomain.
        initializer 'war_engine.middleware.apartment' do
        	Rails.application.config.middleware.use Apartment::Elevators::Subdomain
        end

        # Intercept Braintree sandbox requests and give the expected
        # response, with the URL and the http_status, id and hash parameters
        initializer 'war_engine.middleware.fake_braintree_redirect' do 
            if Rails.env.test?
                require 'fake_braintree_redirect'
                Rails.application.config.middleware.insert_before \
                Apartment::Elevators::Subdomain,
                FakeBraintreeRedirect
            end 
        end
    end
end

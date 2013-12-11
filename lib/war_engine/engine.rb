require 'warden'
module WarEngine
  class Engine < ::Rails::Engine
    isolate_namespace WarEngine

    config.generators do |g|
    	g.test_framework :rspec, :view_specs => false 
    end

    # insert the Warden::Manager middleware into the application’s middleware stack
    initializer 'subscribem.middleware.warden' do 
    	Rails.application.config.middleware.use Warden::Manager
    end
  end
end

module WarEngine
  class ApplicationController < ::ApplicationController

  	# The methods: current_account, current_user, user_signed_in?, authenticate_user!, 
  	# and force_authentication! are now found in extenders/controllers/application_controller_extender.rb
  	# This allows these methods to be available to both engine and application
  	# This extender will need to be loaded so that the methods are made available on ApplicationController.
    # To do that, we can put a new to_prepare hook within the engine’s definition, inside the 
    # WarEngine::Engine class inside lib/subscribem/engine.rb.

    def authorize_owner 
    	unless owner?
	        flash[:error] = "You are not allowed to do that."
	        redirect_to root_path
    	end 
	end
  end
end

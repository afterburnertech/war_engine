require_dependency "war_engine/application_controller"

module WarEngine
  class AccountsController < ApplicationController

  	def new
  		@account = WarEngine::Account.new
  		@account.build_owner
  	end

  	def create
  		# create the account and if valid, add the owner to the list of users
  		@account = WarEngine::Account.create_with_owner(account_params)
  		if @account.valid?
	  		force_authentication!(@account.owner)
	  		@account.create_schema
	  		flash[:success] = "Your account has been successfully created."

	  		#tell rails to route the request to a subdomain
	  		redirect_to war_engine.root_url(:subdomain => @account.subdomain)
	  	else
	  		flash[:error] = "Sorry, your account could not be created."
	  		render :new
	  	end
  	end

  	private

  	# Parameters within Rails 4 are not automatically accepted 
  	# (thanks to the strong_parameters gem), and so we need to 
  	# permit them. We can do this by defining that 
  	# account_params method as a private method after the create
  	# action in this controller:
  	def account_params
  		params.require(:account).permit(:name, :subdomain, { :owner_attributes => [
  	    	:email, :password, :password_confirmation
  	  	]})
  	end

  end
end

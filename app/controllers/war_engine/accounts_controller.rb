require_dependency "war_engine/application_controller"

module WarEngine
  class AccountsController < ApplicationController

  	def new
  		@account = WarEngine::Account.new
  		@account.build_owner
  	end

  	def create
  		@account = WarEngine::Account.create(account_params)
  		# set_user method tells Warden that we want to set the current session’s user to that particular value
  		env['warden'].set_user(@account.owner.id, :scope => :user) 
  		env['warden'].set_user(@account.id, :scope => :account)
  		flash[:success] = "Your account has been successfully created."
  		
  		#tell rails to route the request to a subdomain
  		redirect_to war_engine.root_url(:subdomain => @account.subdomain)
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

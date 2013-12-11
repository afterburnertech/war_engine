require_dependency "war_engine/application_controller"

module WarEngine
  class AccountsController < ApplicationController

  	def new
  		@account = WarEngine::Account.new
  	end

  	def create
  		@account = WarEngine::Account.create(account_params)
  		flash[:success] = "Your account has been successfully created."
  		redirect_to war_engine.root_url
  	end

  	private

  	# Parameters within Rails 4 are not automatically accepted 
  	# (thanks to the strong_parameters gem), and so we need to 
  	# permit them. We can do this by defining that 
  	# account_params method as a private method after the create
  	# action in this controller:
  	def account_params
  		params.require(:account).permit(:name)
  	end

  end
end

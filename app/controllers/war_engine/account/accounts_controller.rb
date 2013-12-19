require_dependency "war_engine/application_controller"

module WarEngine
  class Account::AccountsController < ApplicationController
  	before_filter :authenticate_user!
  	before_filter :authorize_owner, :only => [:edit, :update]

  	def update
  		if current_account.update_attributes(account_params) 
  			flash[:success] = "Account updated successfully." 
  			redirect_to root_path
  		end 
	end

  	private
  	def account_params
	  	params.require(:account).permit(:name) 
	end
  end
end

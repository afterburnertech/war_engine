require_dependency "war_engine/application_controller"

module WarEngine
  class Account::UsersController < ApplicationController

  	def new
  		@user = WarEngine::User.new
  	end

  	def create
  		account = WarEngine::Account.find_by_subdomain!(request.subdomain)
  		user = account.users.create(user_params) 
  		force_authentication!(account, user)
  		flash[:success] = "You have signed up successfully." 
  		redirect_to root_path
  	end

  	private
  		def user_params
  			params.require(:user).permit(:email, :password, :password_confirmation)
  		end
  end
end

require_dependency "war_engine/application_controller"

module WarEngine
  class Account::SessionsController < ApplicationController
  	def new
  		@user = User.new
  	end

  	def create
  		if env['warden'].authenticate(:scope => :user)
  		    flash[:success] = "You are now signed in."
  		    redirect_to root_path
  		else
  		    @user = User.new
  		    flash[:error] = "Invalid email or password."
  		    render :action => "new"
  		end
  	end
  end
end

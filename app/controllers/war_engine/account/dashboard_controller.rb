require_dependency "war_engine/application_controller"

module WarEngine
  class Account::DashboardController < ApplicationController
  	before_filter :authenticate_user!
  end
end

module WarEngine
  class Member < ActiveRecord::Base
  	belongs_to :account, :class_name => "WarEngine::Account"
  	belongs_to :user, :class_name => "WarEngine::User" 
  end
end

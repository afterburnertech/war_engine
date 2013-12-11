#An account’s owner will be responsible for doing admin operations for that account.
module WarEngine
  class Account < ActiveRecord::Base

  	belongs_to :owner, :class_name => "WarEngine::User"
  	accepts_nested_attributes_for :owner
  end
end

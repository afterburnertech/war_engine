#An account’s owner will be responsible for doing admin operations for that account.
module WarEngine
  class Account < ActiveRecord::Base
  	validates :subdomain, :presence => true, :uniqueness => true

  	# make sure there are no illegal characters in the subdomain name
  	validates_format_of :subdomain, :with => /\A[\w\-]+\Z/i,
  	                    :message => "is not allowed. Please choose another subdomain."

  	belongs_to :owner, :class_name => "WarEngine::User"
  	accepts_nested_attributes_for :owner

  	# validation for the subdomain field which rejects any account
  	# that has a subdomain that is within the list of excluded subdomains
  	EXCLUDED_SUBDOMAINS = %w(admin)
  	validates_exclusion_of :subdomain, :in => EXCLUDED_SUBDOMAINS,
  	  :message => 'is not allowed. Please choose another subdomain.'

  	# deal with case sensitivity of subdomain
  	before_validation do
  		self.subdomain = subdomain.to_s.downcase
  	end 

  	has_many :members, :class_name => "WarEngine::Member"
  	has_many :users, :through => :members

  	def self.create_with_owner(params={}) 
  		account = new(params)
	  	if account.save
		  	account.users << account.owner 
		end
		# if not valid, return account object as it stands
	  	account
  	end

  	def create_schema 
  		Apartment::Database.create(subdomain)
	end	

	def owner?(user) 
		owner == user
	end
  end
end

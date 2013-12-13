ActiveRecord::Base.class_eval do 
	# Defines the belongs_to association for an account, 
	# as well as an association on Subscribem::Account for 
	# many objects of the current class.
	def self.scoped_to_account
	    belongs_to :account, :class_name => "WarEngine::Account"
	    association_name = self.to_s.downcase.pluralize
	    WarEngine::Account.has_many association_name.to_sym, :class_name => self.to_s
	end 
end
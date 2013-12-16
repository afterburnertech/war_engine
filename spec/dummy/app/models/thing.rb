class Thing < ActiveRecord::Base
	# Defines the belongs_to association for an account, 
	# as well as an association on Subscribem::Account for 
	# many objects of the current class.
	# see lib/war_engine/active_record_extensions.rb
	# scoped_to_account (no longer need this after Apartment gem)
end

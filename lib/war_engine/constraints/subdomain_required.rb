module WarEngine
	module Constraints
		# This subdomain constraint checks the incoming request 
		# object and sees if it contains a subdomain that’s not www.
		# If those criteria are met, then it will return true. 
		# If not, false.
		# When you pass a class to the constraints method, that class
		# must respond to a matches? method which returns true or false
		class SubdomainRequired
			def self.matches?(request)
				request.subdomain.present? && request.subdomain != "www"
			end
		end 
	end
end
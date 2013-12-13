# As per the Warden Wiki3, the strategy will need to be defined to have a valid? 
# method and a authenticate! method. The valid? method will tell warden whether
# or not the criteria for this strategy to even be considered for the request 
# is valid. The authenticate! method does all the hard work in actually 
# authenticating the user.
Warden::Strategies.add(:password) do 
	# The request object in this instance is actually a Rack::Request object,
	# rather than an ActionDispatch::Request object. This is because the strategy
	# is processed before the request gets to the Rails stack. Therefore we need 
	# to use the ActionDispatch::Http::URL.extract_subdomains method to get the 
	# subdomain for this request. We also need to use strings for the params keys
	# for the same reasons.
	def subdomain
			ActionDispatch::Http::URL.extract_subdomains(request.host, 1) 
	end
	def valid?
		subdomain.present? && params["user"]
	end
	def authenticate!
		if account = WarEngine::Account.where(:subdomain => subdomain).first 
			if u = account.users.where(:email => params["user"]["email"]).first
				if u.authenticate(params["user"]["password"]) 
					return success!(u)
				end 			
			end			
		end
		fail! 
	end
end
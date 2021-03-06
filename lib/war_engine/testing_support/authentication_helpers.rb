module WarEngine
	module TestingSupport
		module AuthenticationHelpers 
			include Warden::Test::Helpers 
			def self.included(base)
				base.after do
					logout
				end 
			end
			def sign_in_as(options={})
				options.each do |scope, object| 
					# provided by the Warden::Test::Helpers module
					login_as(object.id, :scope => scope)
				end 
			end
		end
	end
end
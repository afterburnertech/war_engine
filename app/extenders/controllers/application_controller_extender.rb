# A extender modifies a piece of already existing code,
# such as a class or a module, and adds functionality to it. 
# This is process is also known as monkey patching2. This 
# extender that we’ll create in a moment is going to re-open
# the ApplicationController class and add the current_user, 
# current_account, user_signed_in? and authenticate_user! to it.
::ApplicationController.class_eval do 
	def current_account
		if user_signed_in? 
			@current_account ||= begin
		        account_id = env['warden'].user(:scope => :account)
				WarEngine::Account.find(account_id) 
			end
		end
	end
	helper_method :current_account 

	def current_user
		if user_signed_in? 
			@current_user ||= begin
				user_id = env['warden'].user(:scope => :user)
				WarEngine::User.find(user_id) 
			end
		end 
	end
	helper_method :current_user 

	def user_signed_in?
		env['warden'].authenticated?(:user) 
	end
	helper_method :user_signed_in? 

	def authenticate_user!
		unless user_signed_in? 
			flash[:info] = "Please sign in." 
			redirect_to '/sign_in'
		end
	end
			
	def force_authentication!(user) 
		# set_user method tells Warden that we want to set the 
		# current session’s user to that particular value
		env['warden'].set_user(user.id, :scope => :user) 
	end
end
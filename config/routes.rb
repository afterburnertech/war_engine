require 'war_engine/constraints/subdomain_required'
WarEngine::Engine.routes.draw do
  get "things/index"
	# A subdomain constraint requires that certain routes be 
	# accessed through a subdomain of the application, rather 
	# than at the root. If no subdomain is provided, then the 
	# routes will be ignored and other routes may match this 
	# path.
	constraints(WarEngine::Constraints::SubdomainRequired) do 
		# We’re scoping by a module called Account, 
		# meaning controllers for the routes underneath this 
		# scope will be within the WarEngine::Account namespace,
		# rather than just the WarEngine namespace.
		scope :module => "account" do
			root :to => "dashboard#index", :as => :account_root 
			get '/sign_up', :to => "users#new", :as => :user_sign_up
			post '/sign_up', :to => "users#create", :as => :do_user_sign_up

			get '/sign_in', :to => 'sessions#new'
			post '/sign_in', :to => 'sessions#create', :as => :sessions
		end
	end

	root "dashboard#index"
	get '/sign_up', :to => "accounts#new", :as => :sign_up
	post '/accounts', :to => "accounts#create", :as => :accounts
end

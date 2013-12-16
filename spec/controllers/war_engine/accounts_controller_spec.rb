require'spec_helper' 
describe WarEngine::AccountsController do
	# we want only to ensure that the controller calls these methods,
	# not that it actually follows through with its action.
	context "creates the account's schema" do 
		let!(:account) { stub_model(WarEngine::Account) } 
		before do
	      WarEngine::Account.should_receive(:create_with_owner).and_return(account)
	      account.stub :valid? => true
	      controller.stub(:force_authentication!) 
	  	end
	    specify do
	      account.should_receive(:create_schema)
	      # Subscribem::AccountsController's create route is defined 
	      # within the engine which is mounted in the application. 
	      # Therefore we need to tell the test to look up the route in 
	      # the correct location.
	      post :create, :account => { :name => "First Account" },
            :use_route => :war_engine
	    end
	end
end

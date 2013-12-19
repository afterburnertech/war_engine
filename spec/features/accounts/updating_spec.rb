require'spec_helper' 
require'war_engine/testing_support/factories/account_factory' 
require'war_engine/testing_support/authentication_helpers' 
feature "Accounts" do
	include WarEngine::TestingSupport::AuthenticationHelpers 
	let(:account) { FactoryGirl.create(:account_with_schema) } 
	let(:root_url) { "http://#{account.subdomain}.example.com/" } 
	context "as the account owner" do
		before do
			sign_in_as(:user => account.owner, :account => account)
		end
		scenario "updating an account" do
		      visit root_url
		      click_link "Edit Account"
		      fill_in "Name", :with => "A new name"
		      click_button "Update Account"
		      page.should have_content("Account updated successfully.")
		      account.reload.name.should == "A new name"
		end 
		scenario "updating an account with invalid attributes fails" do 
			visit root_url
			click_link "Edit Account"
			fill_in "Name", :with => ''
		    click_button "Update Account"
		    page.should have_content("Name can't be blank")
		    page.should have_content("Account could not be updated.")
		end
		context "with plans" do
			let!(:starter_plan) do
			    WarEngine::Plan.create(
			      :name  => 'Starter',
			      :price => 9.95,
			      :braintree_id => 'starter'
				)
			end 
			let!(:extreme_plan) do
			    WarEngine::Plan.create(
			      :name  => 'Extreme',
			      :price => 19.95,
			      :braintree_id => 'extreme'
				)
			end 
			before do
				account.update_column(:plan_id, starter_plan.id) 
			end
			scenario "updating an account's plan" do 
				visit root_url
				click_link 'Edit Account'
				select 'Extreme', :from => 'Plan'
			    click_button "Update Account"
			    page.should have_content("Account updated successfully.")
			    page.should have_content("You are now on the 'Extreme' plan.")
			    account.reload.plan.should == extreme_plan
			end 
		end
	end
	context "as a user" do 
		before do
		    user = FactoryGirl.create(:user)
			sign_in_as(:user => user, :account => account) 
		end
		scenario "cannot edit an account's information" do
			visit war_engine.edit_account_url(:subdomain => account.subdomain) 
			page.should have_content("You are not allowed to do that.")
		end 
	end
end
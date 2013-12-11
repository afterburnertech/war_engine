require "spec_helper"
feature 'Accounts' do
	scenario 'creating an account' do
		visit war_engine.root_path
		click_link 'Account Sign Up'
		fill_in 'Name', :with => 'Test'
		fill_in'Email',:with=>'subscribem@example.com'
		fill_in'Password',:with=>'password',:exact=>true
		fill_in'Password confirmation',:with=>'password'
		click_button 'Create Account'
		page.should have_content("Signed in as subscribem@example.com")
		success_message = 'Your account has been successfully created.'
		page.should have_content(success_message)
	end
end
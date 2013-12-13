FactoryGirl.define do
	factory :account, :class => WarEngine::Account do
		sequence(:name) { |n| "Test Account ##{n}" } 
		sequence(:subdomain) { |n| "test#{n}" } 
		association :owner, :factory => :user
		# add the account owner to the users list
		after(:create) do |account|
			account.users << account.owner
		end
	end 
end
require'war_engine/braintree_plan_fetcher' 
namespace :war_engine do
	desc "Import plans from Braintree" 
	task :import_plans => :environment do
		BraintreePlanFetcher.store_locally 
	end
end

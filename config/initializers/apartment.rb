# Exclude some models from Apartment’s scoping
Apartment.excluded_models = ["WarEngine::Account",
                        "WarEngine::Member",
						"WarEngine::User",
						"WarEngine::Plan"]
						
# The pluck method here will fetch all the subdomain values 
# for the records in subscribem_accounts, and will return 
# them in an array. This array is then used by apartment:migrate
# to determine which schemas to migrate. For every subdomain in
# our application, there’s a corresponding schema						
Apartment.database_names = lambda{ WarEngine::Account.pluck(:subdomain) }
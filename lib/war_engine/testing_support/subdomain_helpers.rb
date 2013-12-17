module WarEngine
	module TestingSupport
		module SubdomainHelpers
			# altering Capybara’s default_host variable so that requests are 
			# scoped within a subdomain for the duration of the block, and then
			# it’ll reset it after its done.
			def within_account_subdomain(&block)
				context "within a subdomain" do
					let(:subdomain_url) { "http://#{account.subdomain}.example.com" } 
					before { Capybara.default_host = subdomain_url }
					after { Capybara.default_host = "http://www.example.com" }
					yield
				end 
			end
		end
	end
end
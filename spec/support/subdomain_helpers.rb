module SubdomainHelpers
	# altering Capybara’s default_host variable so that requests are 
	# scoped within a subdomain for the duration of the block, and then
	# it’ll reset it after its done.
	def within_account_subdomain
		let(:subdomain_url) { "http://#{account.subdomain}.example.com" } 
		before { Capybara.default_host = subdomain_url }
		after { Capybara.default_host = "http://example.com" }
		yield
	end 
end
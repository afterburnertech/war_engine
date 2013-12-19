class BraintreePlanFetcher
	def self.store_locally
		Braintree::Plan.all.each do |plan| 
			if local_plan = WarEngine::Plan.find_by_braintree_id(plan.id)
		        local_plan.update_attributes({
		          :name => plan.name,
		          :price => plan.price
				})
			else
				WarEngine::Plan.create({
			        :name => plan.name,
			        :price => plan.price,
			        :braintree_id => plan.id
				})
			end
		end
	end
end
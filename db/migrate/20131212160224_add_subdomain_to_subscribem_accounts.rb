class AddSubdomainToSubscribemAccounts < ActiveRecord::Migration
  def change
    add_column :war_engine_accounts, :subdomain, :string
    add_index :war_engine_accounts, :subdomain
  end
end

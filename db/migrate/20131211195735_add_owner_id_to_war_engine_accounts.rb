class AddOwnerIdToWarEngineAccounts < ActiveRecord::Migration
  def change
    add_column :war_engine_accounts, :owner_id, :integer
  end
end

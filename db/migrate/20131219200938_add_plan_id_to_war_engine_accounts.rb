class AddPlanIdToWarEngineAccounts < ActiveRecord::Migration
  def change
    add_column :war_engine_accounts, :plan_id, :integer
  end
end

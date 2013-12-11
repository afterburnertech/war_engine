class CreateWarEngineAccounts < ActiveRecord::Migration
  def change
    create_table :war_engine_accounts do |t|
      t.string :name

      t.timestamps
    end
  end
end

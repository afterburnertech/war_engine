class CreateWarEngineUsers < ActiveRecord::Migration
  def change
    create_table :war_engine_users do |t|
      t.string :email
      t.string :password_digest

      t.timestamps
    end
  end
end

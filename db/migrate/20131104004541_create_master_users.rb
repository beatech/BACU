class CreateMasterUsers < ActiveRecord::Migration
  def change
    create_table :master_users do |t|
      t.integer :user_id
      t.float :total_score

      t.timestamps
    end
  end
end

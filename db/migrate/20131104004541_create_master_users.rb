class CreateMasterUsers < ActiveRecord::Migration
  def change
    create_table :master_users do |t|
      t.integer :user_id
      t.decimal :total_score, precision: 10, scale: 2

      t.timestamps
    end
  end
end

class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :twitter_account_id
      t.integer :circle_id
      t.string :name

      t.timestamps
    end
  end
end

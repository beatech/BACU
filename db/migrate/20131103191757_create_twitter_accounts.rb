class CreateTwitterAccounts < ActiveRecord::Migration
  def change
    create_table :twitter_accounts do |t|
      t.integer :uid
      t.string :screen_name

      t.timestamps
    end
  end
end

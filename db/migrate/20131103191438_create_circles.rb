class CreateCircles < ActiveRecord::Migration
  def change
    create_table :circles do |t|
      t.integer :twitter_account_id
      t.string :name
      t.string :url
      t.string :university

      t.timestamps
    end
  end
end

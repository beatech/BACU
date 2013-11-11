class CreateTips < ActiveRecord::Migration
  def change
    create_table :tips do |t|
      t.integer :master_music_id
      t.integer :game_music_id
      t.integer :user_id
      t.text :content

      t.timestamps
    end
  end
end

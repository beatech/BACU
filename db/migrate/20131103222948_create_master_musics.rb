class CreateMasterMusics < ActiveRecord::Migration
  def change
    create_table :master_musics do |t|
      t.string :title
      t.string :difficulty
      t.integer :game_id

      t.timestamps
    end
  end
end

class CreateGameMusics < ActiveRecord::Migration
  def change
    create_table :game_musics do |t|
      t.string :title
      t.string :difficulty
      t.integer :game_id

      t.timestamps
    end
  end
end

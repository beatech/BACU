class AddIndex < ActiveRecord::Migration
  def change
    add_index :master_musics, [:game_id, :music_order], name: :idx_game_id_music_order
    add_index :game_musics, [:game_id, :music_order], name: :idx_game_id_music_order
  end
end

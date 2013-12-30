class TipsAddIndex < ActiveRecord::Migration
  def change
    add_index :tips, :master_music_id, name: :idx_master_music_id
    add_index :tips, :game_music_id, name: :idx_game_music_id
  end
end

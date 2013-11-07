class AddColumnOrderToGameMusics < ActiveRecord::Migration
  def change
    add_column :game_musics, :music_order, :integer
  end
end

class AddColumnOrderToGameMusics < ActiveRecord::Migration
  def change
    add_column :game_musics, :order, :integer
  end
end

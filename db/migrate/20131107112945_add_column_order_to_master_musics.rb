class AddColumnOrderToMasterMusics < ActiveRecord::Migration
  def change
    add_column :master_musics, :music_order, :integer
  end
end

class AddColumnOrderToMasterMusics < ActiveRecord::Migration
  def change
    add_column :master_musics, :order, :integer
  end
end

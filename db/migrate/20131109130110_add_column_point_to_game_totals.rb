class AddColumnPointToGameTotals < ActiveRecord::Migration
  def change
    add_column :game_totals, :point, :integer
  end
end

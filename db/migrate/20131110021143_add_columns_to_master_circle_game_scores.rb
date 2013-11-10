class AddColumnsToMasterCircleGameScores < ActiveRecord::Migration
  def change
    add_column :master_circle_game_scores, :master_circle_id, :integer
    add_column :master_circle_game_scores, :game_id, :integer
  end
end

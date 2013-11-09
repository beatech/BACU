class CreateMasterCircleGameScores < ActiveRecord::Migration
  def change
    create_table :master_circle_game_scores do |t|
      t.decimal :average, precision: 10, scale: 2
      t.integer :point

      t.timestamps
    end
  end
end

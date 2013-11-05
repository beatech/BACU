class CreateGameScores < ActiveRecord::Migration
  def change
    create_table :game_scores do |t|
      t.decimal :score, precision: 10, scale: 2
      t.integer :game_music_id
      t.integer :game_total_id

      t.timestamps
    end
  end
end

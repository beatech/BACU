class CreateMasterScores < ActiveRecord::Migration
  def change
    create_table :master_scores do |t|
      t.integer :master_user_id
      t.integer :master_music_id
      t.float :basic_score
      t.float :score

      t.timestamps
    end
  end
end

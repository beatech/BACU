class CreateMasterScores < ActiveRecord::Migration
  def change
    create_table :master_scores do |t|
      t.integer :master_user_id
      t.integer :master_music_id
      t.decimal :basic_score, precision: 10, scale: 2
      t.decimal :score, precision: 10, scale: 2

      t.timestamps
    end
  end
end

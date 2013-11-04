class CreateGameTotals < ActiveRecord::Migration
  def change
    create_table :game_totals do |t|
      t.decimal :total_score, precision: 10, scale: 8
      t.integer :game_id
      t.integer :user_id

      t.timestamps
    end
  end
end

class CreateMasterCircles < ActiveRecord::Migration
  def change
    create_table :master_circles do |t|
      t.integer :circle_id
      t.decimal :total_score, precision: 10, scale: 8

      t.timestamps
    end
  end
end

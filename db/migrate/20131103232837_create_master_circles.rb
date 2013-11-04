class CreateMasterCircles < ActiveRecord::Migration
  def change
    create_table :master_circles do |t|
      t.integer :circle_id
      t.float :total_score

      t.timestamps
    end
  end
end

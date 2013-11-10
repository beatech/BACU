class AddColumnCircles < ActiveRecord::Migration
  def change
    add_column :circles, :point, :integer
  end
end

class AddColumnMasterCirclesAllAverage < ActiveRecord::Migration
  def change
    add_column :master_circles, :all_average, :decimal, precision: 10, scale: 2
    add_column :master_circles, :all_average_point, :integer
  end
end

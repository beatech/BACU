class AddColumnIndividualPointToMasterUsers < ActiveRecord::Migration
  def change
    add_column :master_users, :individual_point, :integer
  end
end

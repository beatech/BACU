class AddColumnInsuranceScoreToMasterMusics < ActiveRecord::Migration
  def change
    add_column :master_musics, :insurance_score, :decimal, precision: 10, scale: 2
  end
end

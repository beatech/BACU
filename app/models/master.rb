module Master
  def self.table_name_prefix
    'master_'
  end

  def self.update_all_scores
    Master::User.update_total_score
    Master::Circle.update_total_score
  end
end

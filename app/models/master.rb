module Master
  def self.table_name_prefix
    'master_'
  end

  def self.update_all_scores
    self.prepare_master_users
    self.prepare_master_scores
    self.update_1st_order_scores
    self.update_2nd_order_scores
    Master::User.update_total_score
    self.expire_master_index
  end

  def self.prepare_master_users
    ::User.all.each do |user|
      Master::User.create(user_id: user.id, total_score: 0) if user.master_user.blank?
    end
  end

  def self.prepare_master_scores
    Master::User.all.each do |master_user|
      Master::Music.all.each do |master_music|
        master_score = Master::Score.where(master_user_id: master_user.id, master_music_id: master_music.id)
          .first_or_create(score: 0, basic_score: 0)
      end
    end
  end

  def self.update_1st_order_scores
    Master::Music.where(music_order: 1).each do |master_music|
      master_music.update_scores_for_1st_order
    end
  end

  def self.update_2nd_order_scores
    Master::Music.where(music_order: 2).each do |master_music|
      master_music.update_scores_for_2nd_order
    end
  end

  def self.expire_master_index
    ActionController::Base.expire_page('/master')
  end
end

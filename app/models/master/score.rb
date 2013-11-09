class Master::Score < ActiveRecord::Base
  belongs_to :master_user, class_name: 'Master::User'
  belongs_to :master_music, class_name: 'Master::Music'
  validates :master_user_id, presence: true
  validates :master_music_id, presence: true
  validates :basic_score, presence: true
  validates :score, presence: true

  # 課題曲2用 insurance_scoreとbasic_scoreの高い方を返す
  def insuranced_basic_score
    insurance_score = self.master_music.insurance_score
    if insurance_score && insurance_score > 0 && insurance_score > self.basic_score
      insurance_score
    else
      basic_score
    end
  end

  def basic_score_for_point
    if self.master_music.music_order == 2
      self.insuranced_basic_score
    else
      self.basic_score
    end
  end

  def update_all_scores
    prepare_master_users
    prepare_master_scores
    update_1st_order_scores
    update_2nd_order_scores
    Master::User.update_total_score
  end

  def prepare_master_users
    ::User.all.each do |user|
      Master::User.create(user_id: user.id, total_score: 0) if user.master_user.blank?
    end
  end

  def prepare_master_scores
    Master::User.all.each do |master_user|
      Master::Music.all.each do |master_music|
        master_score = Master::Score.where(master_user_id: master_user.id, master_music_id: master_music.id)
          .first_or_create(score: 0, basic_score: 0)
      end
    end
  end

  def update_1st_order_scores
    Master::Music.where(music_order: 1).each do |master_music|
      master_music.update_scores_for_1st_order
    end
  end

  def update_2nd_order_scores
    Master::Music.where(music_order: 2).each do |master_music|
      master_music.update_scores_for_2nd_order
    end
  end
end

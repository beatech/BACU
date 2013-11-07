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
end

class Master::Score < ActiveRecord::Base
  belongs_to :master_user, class_name: 'Master::User'
  belongs_to :master_music, class_name: 'Master::Music'
  validates :master_user_id, presence: true
  validates :master_music_id, presence: true
  validates :basic_score, presence: true
  validates :score, presence: true

  def update_basic_score(new_basic_score)
    if self.basic_score != new_basic_score
      self.basic_score = new_basic_score
      self.save

      self.master_music.update_scores
    end
  end
end

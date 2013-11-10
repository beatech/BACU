class Master::Circle::GameScore < ActiveRecord::Base
  belongs_to :master_circle,
    class_name: 'Master::Circle',
    foreign_key: :master_circle_id,
    touch: true
  belongs_to :game,
    class_name: '::Game',
    foreign_key: :game_id,
    touch: true
  has_many :master_musics,
    class_name: '::Master::Music',
    through: :game

  validate :master_circle_id, presence: true
  validate :game_id, presence: true
  validate :average, presence: true
  validate :point, presence: true

  def self.update_average
    Master::Circle::GameScore.all.each do |master_circle_game_score|
      master_circle = master_circle_game_score.master_circle
      score_count = 0
      score_sum = 0
      master_circle_game_score.master_musics.each do |master_music|
        master_scores = master_circle.master_scores.where(master_music_id: master_music.id)
        score_count += master_scores.count
        master_scores.each do |master_score|
          score_sum += master_score.score
        end
      end
      master_circle_game_score.average = score_sum.to_f / score_count
      master_circle_game_score.save
    end
  end

  def self.update_point
    Game.all.each do |game|
      master_circle_game_scores = game.master_circle_game_scores.order('average DESC')
      master_circle_game_scores.each_with_index do |master_circle_game_score, index|
        master_circle_game_score.point = case index
                                         when 0 then 35
                                         when 1 then 20
                                         else 0
                                         end
        master_circle_game_score.save
      end
    end
  end
end

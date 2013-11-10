class Master::Score < ActiveRecord::Base
  belongs_to :master_user,
    class_name: 'Master::User',
    foreign_key: :master_user_id,
    touch: true
  belongs_to :master_music,
    class_name: 'Master::Music',
    foreign_key: :master_music_id,
    touch: true
  has_one :game,
    class_name: '::Game',
    through: :master_music

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
    prepare_master_circles
    prepare_game_scores
    update_1st_order_scores
    update_2nd_order_scores
    update_all_points
  end

  def update_all_points
    Master::User.update_total_score
    Master::User.update_individual_point
    Master::Circle::GameScore.update_average
    Master::Circle::GameScore.update_point
    Master::Circle.update_all_average
    Master::Circle.update_all_average_point
    Game::Total.update_point
    Circle.update_point
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

  def prepare_master_circles
    ::Circle.all.each do |circle|
      master_circle = Master::Circle.where(circle_id: circle.id)
        .first_or_create(total_score: 0, all_average: 0, all_average_point: 0)
      Game.all.each do |game|
        Master::Circle::GameScore.where(master_circle_id: master_circle.id, game_id: game.id)
          .first_or_create(average: 0, point: 0)
      end
    end
  end

  def prepare_game_scores
    ::User.all.each do |user|
      ::Game.all.each do |game|
        game_total = ::Game::Total.where(user_id: user.id, game_id: game.id)
          .first_or_create(total_score: 0, point: 0)
        game.game_musics.each do |game_music|
          ::Game::Score.where(game_music_id: game_music.id, game_total_id: game_total.id)
            .first_or_create(score: 0)
        end
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

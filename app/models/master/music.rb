class Master::Music < ActiveRecord::Base
  MAX_INTEGER = 1000

  belongs_to :game
  has_many :master_scores, class_name: 'Master::Score'
  validates :title, presence: true
  validates :difficulty, presence: true
  validates :game_id, presence: true

  def update_scores_for_1st_order
    min_standard_score = MAX_INTEGER
    @master_scores = Master::Score.where(master_music_id: self.id)
    @average = basic_score_average
    @standard_deviation = standard_deviation(@average)
    @master_scores.select{ |s| s.basic_score > 0 }.each do |master_score|
      current_standard_score = standard_score(master_score.basic_score, @average, @standard_deviation)
      if current_standard_score > 0
        min_standard_score = current_standard_score if current_standard_score < min_standard_score
        master_score.score = current_standard_score
        master_score.save
      end
    end

    min_standard_score = 50 if min_standard_score == MAX_INTEGER
    @master_scores.select{ |s| s.basic_score == 0 }.each do |zero_master_score|
      zero_master_score.score = min_standard_score - 10
      zero_master_score.save
    end
  end

  # 基礎点(素のスコア)の平均
  def basic_score_average
    basic_score_sum = Master::Score.where(master_music_id: self.id).inject(0) { |basic_score_sum, master_score|
      basic_score_sum + master_score.basic_score_for_point
    }
    basic_score_sum.to_f / Master::Score.where(master_music_id: self.id).select{ |s| s.basic_score > 0 }.count
  end

  # 分散
  def variance(average)
    sum = 0
    num = 0
    Master::Score.where(master_music_id: self.id).each do |master_score|
      if master_score.basic_score_for_point > 0
        sum += (master_score.basic_score_for_point - average)**2
        num += 1
      end
    end

    if num > 0
      sum.to_f / num
    else
      0
    end
  end

  # 標準偏差
  def standard_deviation(average)
    Math.sqrt(variance(average))
  end

  # 偏差値
  def standard_score(score, average, standard_deviation)
    return 0 if score == 0

    gap = 0
    if standard_deviation != 0
      gap = (score - average) / standard_deviation
      gap *= 10
    end

    gap.to_f + 50
  end

  def update_scores_for_2nd_order
    @master_scores = Master::Score.where(master_music_id: self.id)
    @average = basic_score_average
    @standard_deviation = standard_deviation(@average)
    @master_scores.all.each do |master_score|
      master_score.score = standard_score(master_score.basic_score_for_point, @average, @standard_deviation)
      master_score.save
    end
  end
end

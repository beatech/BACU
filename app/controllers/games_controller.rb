class GamesController < ApplicationController
  layout 'layouts/single_column'
  before_filter :require_login, only: [:edit, :update]

  def edit
    @user = @twitter_account.user
  end

  def update
    user = User.find(params[:user_id])
    redirect_to games_path unless user.present?
    Game.all.each do |game|
      total_score = 0
      game_total = Game::Total.where(user_id: 1, game_id: game.id).first
      game_total = Game::Total.create(game_id: game.id, user_id: user.id, total_score: 0) if game_total.blank?
      game.game_musics.each do |music|
        game_score = Game::Score.where(game_total_id: game_total.id, game_music_id: music.id).first
        game_score = Game::Score.create(game_total_id: game_total.id, game_music_id: music.id, score: 0) if game_score.blank?
        game_score.score = params[:music][music.id.to_s].to_f
        total_score += game_score.score
        game_score.save
      end
      game_total.total_score = total_score
      game_total.save
    end
    redirect_to games_path
  end

  def score_ranking
    @game = Game.find(params[:id])
    respond_to { |format| format.js }
  end

  private
  def require_login
    redirect_to root_url unless @twitter_account && @twitter_account.user.present?
  end
end

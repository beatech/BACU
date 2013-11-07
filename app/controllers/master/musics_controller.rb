class Master::MusicsController < ApplicationController
  layout 'layouts/single_column'
  before_filter :require_master, only: [:edit, :update]

  def index
  end

  def edit
  end

  def update
    Game.all.each do |game|
      game.master_musics.each do |music|
        insurance_score = params[:insurance][music.id.to_s]
        music.insurance_score = insurance_score
        music.save
      end
    end
    redirect_to master_musics_path
  end

  def ajax_load
    respond_to { |format| format.js }
  end

  private
  def require_master
    redirect_to root_url unless @twitter_account && @twitter_account.screen_name == 'ikstrm'
  end
end

class Master::MusicsController < ApplicationController
  layout 'layouts/single_column'
  before_filter :require_admin, only: [:edit, :update]

  def index
  end

  def edit
  end

  def update
    Game.all.each do |game|
      game.master_musics.each do |music|
        difficulty = params[:difficulty][music.id.to_s]
        title = params[:title][music.id.to_s]
        music.difficulty = difficulty
        music.title = title
        music.save
      end
    end
    redirect_to master_musics_path
  end

  def ajax_load
    respond_to { |format| format.js }
  end
end

class PagesController < ApplicationController
  def home
    @solo = Game.find_by(name: "Chanson du jour")
    @playlist = Game.find_by(name: "Playlist")
    @session = GameSession.new
  end
end

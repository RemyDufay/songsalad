class PagesController < ApplicationController
  def home
    @game_session = GameSession.new()
  end
end

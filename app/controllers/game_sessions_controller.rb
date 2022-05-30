class GameSessionsController < ApplicationController
  def create
    @game_session = GameSession.new(game_session_params)
  end

  def show
    @game_session = GameSession.find(params[:id])
    @guest = @game_session.guest
  end

  def all
    @all = game_session.all.where(guest_id)
  end

  private

  def game_session_params
    params.require(:game_session).permit(:guest_id, :game_id, :victory?)
  end
end

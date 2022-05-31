class GuestsController < ApplicationController
  def destroy
    @guests = GameSession.find(params[:id])
    @guests.destroy

    redirect_to stats_guest_path
  end
end

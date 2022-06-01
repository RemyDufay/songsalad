class GuestsController < ApplicationController
  def reset
    @guests = Guest.find(params[:id])
    @guests.destroy

    redirect_to stats_guest_path
  end
end

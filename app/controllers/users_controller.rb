class UsersController < ApplicationController
  def reset
    session[:guest_id] = nil
    redirect_to root_path
  end


  def stats

    @user = current_user
    @sessions = GameSession.where(user_id:@user)
    @sessionscount = @sessions.count
    @songsplayed = GameSessionSong.where(game_session_id: @sessions, status:"done" )
    @songsplayedcount = @songsplayed.count
    totalguesses = 0
    @songsplayed.each do |song|
      totalguesses += song.guesses.count
    end
    @averageguesses =  @songsplayedcount == 0 ? "-" : totalguesses /  @songsplayedcount
  end




end

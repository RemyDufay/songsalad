require 'nokogiri'
require 'open-uri'

class GameSessionsController < ApplicationController

  def create
    @game_session = GameSession.new
    @game_session.guest = Guest.last
    @game_session.game = Game.last
    @game_session.save!
    redirect_to game_session_path(@game_session)
  end

  def show

    @game_session = GameSession.find(params[:id])
    @game_song = @game_session.game.game_songs[0]
    @game_session_songs = GameSessionSong.create!(game_session: @game_session, game_song: @game_song )
    @lyrics = @game_song.song.splitted_lyrics

    @lyrics.map! do |word|
          if @game_session_songs.guessed_lyrics_index[word][:guessed]
            word
          elsif word == "\n"
            "<br>"
          else
            redact(word)
      end
    end

    if params[:query].present?
      word = params[:query].downcase.strip
      frequency  = 0
      Guess.create!(game_session_song: @game_session_songs, word: word, frequency: frequency)
      redirect_to game_session_path(@game_session)
    end

end


  def victory
    @game_session = GameSession.find(params[:id])
    @player = @game_session.guest
  end

  private

  def redact(word)
    redacted = ""
    word.each_char do |char|
      (char =~ /[[:alpha:]]/) ? redacted += "█" : redacted += char
    end
    return redacted
  end


  def game_session_params
    params.require(:game_session).permit(:guest_id, :game_id, :victory?)
  end

end

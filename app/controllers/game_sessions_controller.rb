require 'nokogiri'
require 'open-uri'

class GameSessionsController < ApplicationController
  def create
    if guest_present?
      guest = current_guest
    else
      guest = Guest.create
      session[:guest_id] = guest.id
    end

    @game_session = GameSession.new
    @game_session.guest = guest
    @game_session.game = Game.last
    @game_session.save!
    redirect_to game_session_path(@game_session)
  end

  def show
    @game_session = GameSession.find(params[:id])
    @game_song = @game_session.game.game_songs[0]

    if GameSessionSong.find_by(game_session: @game_session, game_song: @game_song).nil?
      @game_session_song = GameSessionSong.create!(game_session: @game_session, game_song: @game_song)
    else
      @game_session_song = GameSessionSong.find_by(game_session: @game_session, game_song: @game_song)
    end

    @lyricsrender = @game_session_song.game_song.song.splitted_lyrics

    @lyricsrender.map! do |word|
      if word == "\n"
        "<br>"
      elsif @game_session_song.guessed_lyrics_index[word.downcase]["guessed"]
        word
      else
        redact(word)
      end
    end

    if params[:query].present?
      word = params[:query].downcase.strip
      frequency = 0

      if !@game_session_song.guessed_lyrics_index[word].nil?
        @game_session_song.guessed_lyrics_index[word]["guessed"] = true
        frequency = @game_session_song.guessed_lyrics_index[word]["count"]
        @game_session_song.save
      end

      if Guess.where(game_session_song: @game_session_song, word: word).empty?
        Guess.create!(game_session_song: @game_session_song, word: word, frequency: frequency)
      end

      redirect_to game_session_path(@game_session)
    end

    if @lyricsrender.join.include? @game_session_song.game_song.song.title
      redirect_to victory_game_session_path(@game_session)
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

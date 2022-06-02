require 'nokogiri'
require 'open-uri'

class GameSessionsController < ApplicationController
  def create
    game = Game.find(params[:game_id])
    if guest_present?
      guest = current_guest
    else
      guest = Guest.create
      session[:guest_id] = guest.id
    end

    if GameSession.find_by(guest: guest, game: game).nil?
    game_session = GameSession.new
    game_session.guest = guest
    game_session.game = game
    game_session.save!
    else
    game_session = GameSession.find_by(guest: guest, game: game)
    end
    redirect_to game_game_session_path( game_id: game.id, id: game_session.id )
  end

  def show
    # Init des variables de la partie
    @game_session = GameSession.find(params[:id])
    @game_songs = @game_session.game.game_songs

    create_game_session_songs
    #chargement de la variable @game_session_song qui contient la chanson en cours
    select_ongoing_song
    if @game_session_song.nil?
      redirect_to victory_game_game_session_path(game_id: params[:game_id], id: params[:id]) and return
    end
    # Prise d'input, création des guesses, maj de l'index des guess de la song
    verify_user_word_input
    # Render des paroles censurées, en fonction des guess existantes
    lyrics_render
    # Vérification des conditions de victoire et passage de la chanson en "done" si c'est le cas
    check_song_victory
  end

  def victory
    @game_session = GameSession.find(params[:id])
    @game_session_song = GameSessionSong.find_by(game_session: @game_session, game_song: @game_song)
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

  def create_game_session_songs
    if GameSessionSong.find_by(game_session: @game_session).nil?
      @game_songs.each do |game_song|
        GameSessionSong.create!(game_session: @game_session, game_song: game_song)
      end
      @game_session_song = GameSessionSong.where(game_session: @game_session).first
      @game_session_song.status = "ongoing"
      @game_session_song.save
    end

  end

  # Verif si il y a une chanson ongoing ou non. Si non, passage à la prochaine. Si pas de prochaine, victoire
  def select_ongoing_song
    if GameSessionSong.where(game_session: @game_session, status: "ongoing").exists?
      @game_session_song = GameSessionSong.find_by(game_session: @game_session, status: "ongoing")
    elsif GameSessionSong.where(game_session: @game_session, status: nil ).exists?
      @game_session_song = GameSessionSong.where(game_session: @game_session, status: nil ).first
      @game_session_song.status = "ongoing"
      @game_session_song.save
    end

  end

  def verify_user_word_input
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
    end
  end

  def check_song_victory
    if @lyricsrender.join.include? @game_session_song.game_song.song.title
      @game_session_song.status = "done"
      @game_session_song.save
      redirect_to game_game_session_path(game_id: params[:game_id], id: params[:id])
    end
  end

  def lyrics_render
    @lyricsrender = @game_session_song.game_song.song.splitted_lyrics.map! do |word|
      if word == "\n"
        "<br>"
      elsif @game_session_song.guessed_lyrics_index[word.downcase]["guessed"]
        word
      else
        redact(word)
      end
    end
  end
end

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
    @SPLITTING_REGEXP = /(\w{3,}'\w{3,}|\\n|[a-zA-Z\u00C0-\u00FF]+|\s|\W|\w\W\w)/
    @game_session = GameSession.find(params[:id])
    @game = @game_session.game
    @game_songs = @game_session.game.game_songs
    @guess = Guess.new
    @songs_count = @game_songs.count
    @songs_done_count = GameSessionSong.where(game_session: @game_session, status: "done").count

    if @songs_count == @songs_done_count
      redirect_to victory_game_game_session_path(game_id: params[:game_id], id: params[:id]) and return
    end
    
    # Si c'est la premiere fois que le joueur joue, on crée les chansons de la session
    create_game_session_songs

    # Chargement de la variable @game_session_song qui contient la chanson en cours
    # Si plus de chanson en cours : écran de victoire final
    select_ongoing_song
    @title = @game_session_song.game_song.song.title.downcase.split(/\W/)


    # On stock les paroles censurées/trouvées dans une variable
    @lyricsrender = @game_session_song.guessed_splitted_lyrics

    @guesses_ordered_by_latest = @game_session_song.
      guesses.
      order(created_at: :desc)

  end

  def victory
    @game_session = GameSession.find(params[:id])
    @game_session_song = GameSessionSong.find_by(game_session: @game_session, game_song: @game_song)
    @guesses_count = @game_session.game_session_songs[0].guesses.count
  end

  private

  def game_session_params
    params.require(:game_session).permit(:guest_id, :game_id, :victory?)
  end


  # Methode qui crée les game_sessions_songs au premier lancement de la session
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

  # Si les guesses contiennent les mots du titre : on marque la song comme done.



end

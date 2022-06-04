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
    @SPLITTING_REGEXP = /(\w{3,}'\w{3,}|\\n|[a-zA-Z\u00C0-\u00FF]+|\s|\W|\w\W\w)/

    # Si c'est la premiere fois que le joueur joue, on crée les chansons de la session
    create_game_session_songs

    # Chargement de la variable @game_session_song qui contient la chanson en cours
    # Si plus de chanson en cours : écran de victoire final
    select_ongoing_song
    if @game_session_song.nil?
      redirect_to victory_game_game_session_path(game_id: params[:game_id], id: params[:id]) and return
    end


    # Prise d'input, création des guesses, maj de l'index des guess de la song
    verify_user_word_input

    # On stock les paroles censurées/trouvées dans une variable
    @lyricsrender = @game_session_song.guessed_splitted_lyrics

    # Vérification des conditions de victoire de la chanson et passage de la chanson en "done" si c'est le cas
    check_song_victory
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

   # Si il y a une query dans l'url
   # On split la query et on met l'array dans une variable
   # Pour chaque mot de l aquery, on update l'index, on y récupére la fréquence du mot
   # Via les position dans l'index, on révéle tous les mots censurés à ces positions
   # On crée les guesses, utile pour générer la liste de propositions.

    if params[:query].present?
      words = params[:query].downcase.split(@SPLITTING_REGEXP).reject(&:blank?)
      frequency = 0

      words.each do |word|
        if @game_session_song.guessed_lyrics_index.has_key?(word)
          @game_session_song.guessed_lyrics_index[word]["guessed"] = true
          frequency = @game_session_song.guessed_lyrics_index[word]["count"]
          @game_session_song.guessed_lyrics_index[word]["positions"].each do |position|
            @game_session_song.guessed_splitted_lyrics[position-1] = @game_session_song.game_song.song.splitted_lyrics[position-1]
          end
          @game_session_song.save
        end

        if Guess.where(game_session_song: @game_session_song, word: word).empty?
          Guess.create!(game_session_song: @game_session_song, word: word, frequency: frequency)
        end
      end

    end
  end

  # Si les paroles censurées ont le titre visible : on amene sur l'écran de victoire

  def check_song_victory
    if @lyricsrender.join.include? @game_session_song.game_song.song.title
      @game_session_song.status = "done"
      @game_session_song.save
      redirect_to game_game_session_path(game_id: params[:game_id], id: params[:id])
    end
  end

end

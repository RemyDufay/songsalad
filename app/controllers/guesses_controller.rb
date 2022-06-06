class GuessesController < ApplicationController

  def create
    @regexp = /(\w{3,}'\w{3,}|\\n|[a-zA-Z\u00C0-\u00FF]+|\s|\W|\w\W\w)/
    @game_session_song = GameSessionSong.find(params[:game_session_song_id])
    @game_session = @game_session_song.game_session
    @game = @game_session.game
    words = guess_params[:word].downcase.split(@regexp).reject(&:blank?)


    words.each do |word|
      if Guess.where(game_session_song: @game_session_song, word: word).empty?
        @guess = Guess.new(game_session_song: @game_session_song, word: word, frequency: 0)
        update_index(word)
        @guess.save!
      end
    end

  redirect_to game_game_session_path(@game, @game_session,  anchor: "#{words[0]}")
  end

  private

  def guess_params
    params.require(:guess).permit(:word)
  end

  def update_index(word)
    if @game_session_song.guessed_lyrics_index.has_key?(word)
      @game_session_song.guessed_lyrics_index[word]["guessed"] = true
      @game_session_song.guessed_lyrics_index[word]["positions"].each do |position|
        @game_session_song.guessed_splitted_lyrics[position-1] = "<span data-color-target='guessed' class='new animate__animated animate__swing'>#{@game_session_song.game_song.song.splitted_lyrics[position-1]}</span>"
      end
      @game_session_song.save!
      @guess.frequency = @game_session_song.guessed_lyrics_index[word]["count"]
    end
  end

end

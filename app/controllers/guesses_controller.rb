class GuessesController < ApplicationController

  def create
    @regexp = /(\w{3,}'\w{3,}|\\n|[a-zA-Z\u00C0-\u00FF]+|\s|\W|\w\W\w)/

    @game_session_song = GameSessionSong.find(params[:game_session_song_id])
    @game_session      = @game_session_song.game_session
    @game              = @game_session.game

    words = guess_params[:word].downcase.split(@regexp).reject(&:blank?)

    words.each do |word|
      if @game_session_song.guesses.where(word: word).empty?
        guess = Guess.new(game_session_song: @game_session_song, word: word, frequency: 0)
        guess.update_index

        guess.save!
      end
    end

    @guesses_ordered_by_latest = @game_session_song.
      guesses.
      order(created_at: :desc)

    respond_to do |format|
      format.html { redirect_to game_game_session_path(@game, @game_session) }
      format.json # Follow the classic Rails flow and look for a create.json view
    end
  end

  private

  def guess_params
    params.require(:guess).permit(:word)
  end
end

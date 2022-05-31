class AddGameSessionSongFromGuess < ActiveRecord::Migration[6.1]
  def change
    add_reference :guesses, :game_session_song, index: true, foreign_key: true

  end
end

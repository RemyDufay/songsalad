class RemoveGameSessionFromGuess < ActiveRecord::Migration[6.1]
  def change
    remove_reference :guesses, :game_session, null: false, foreign_key: true
  end
end

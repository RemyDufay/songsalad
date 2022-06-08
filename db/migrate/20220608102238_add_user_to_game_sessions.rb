class AddUserToGameSessions < ActiveRecord::Migration[6.1]
  def change
    add_reference :game_sessions, :user, foreign_key: true
  end
end

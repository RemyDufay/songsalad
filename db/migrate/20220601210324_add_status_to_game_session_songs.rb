class AddStatusToGameSessionSongs < ActiveRecord::Migration[6.1]
  def change
    add_column :game_session_songs, :status, :string
  end
end

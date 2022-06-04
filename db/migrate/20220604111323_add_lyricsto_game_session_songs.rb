class AddLyricstoGameSessionSongs < ActiveRecord::Migration[6.1]
  def change
    add_column :game_session_songs, :guessed_splitted_lyrics, :jsonb, default: []
  end
end

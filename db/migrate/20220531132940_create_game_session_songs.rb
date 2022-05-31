class CreateGameSessionSongs < ActiveRecord::Migration[6.1]
  def change
    create_table :game_session_songs do |t|
      t.references :game_session, null: false, foreign_key: true
      t.references :game_song, null: false, foreign_key: true
      t.jsonb :guessed_lyrics_index, default: {}

      t.timestamps
    end
  end
end

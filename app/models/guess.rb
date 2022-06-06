class Guess < ApplicationRecord
  belongs_to :game_session_song
  validates :word, presence: true

  def successful?
    game_session_song.guessed_lyrics_index[word][:guessed] == true
  end

  def update_index
    if game_session_song.guessed_lyrics_index.has_key?(word)
      game_session_song.guessed_lyrics_index[word]["guessed"] = true
      game_session_song.guessed_lyrics_index[word]["positions"].each do |position|
        game_session_song.guessed_splitted_lyrics[position-1] = game_session_song.game_song.song.splitted_lyrics[position-1]
      end
      game_session_song.save!
      self.frequency = game_session_song.guessed_lyrics_index[word]["count"]
    end
  end
end

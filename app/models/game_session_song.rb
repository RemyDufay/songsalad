class GameSessionSong < ApplicationRecord
  belongs_to :game_session
  belongs_to :game_song
  has_many :guesses
  after_create :build_guessed_lyrics_index


def build_guessed_lyrics_index

  self.guessed_lyrics_index = self.game_song.song.lyrics_index.each do |k, v|
    if k =~ /[[A-zÀ-ú-œ]]/
      v[:guessed] = false
    else
      v[:guessed] = true
    end
  end
  self.save
end




end

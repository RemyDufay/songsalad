class GameSessionSong < ApplicationRecord
  belongs_to :game_session
  belongs_to :game_song
  has_many :guesses
  after_create :build_guessed_lyrics_index
  after_create :build_guessed_splitted_lyrics

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


def build_guessed_splitted_lyrics

  self.guessed_splitted_lyrics = self.game_song.song.splitted_lyrics.map do |word|
    if word =~ /[[A-zÀ-ú-œ]]/
      redact(word)
    else
      word
    end
  end
  self.save
end


private


def redact(word)
  redacted = ""
  word.each_char do |char|
    (char =~ /[[:alpha:]]/) ? redacted += "█" : redacted += char
  end
  return redacted
end



end

class Song < ApplicationRecord
  has_many :game_songs
  after_create :build_splitted_lyrics
  after_create :build_lyrics_index

SPLITTING_REGEXP = /(\w{3,}'\w{3,}|[a-zA-Z\u00C0-\u00FF]+|\s|\W|\w\W\w)/

def build_splitted_lyrics
  self.splitted_lyrics = self.lyrics.split(SPLITTING_REGEXP).map(&:chomp).reject(&:empty?)
  self.save
end

def build_lyrics_index
  self.lyrics_index = self.splitted_lyrics.each_with_index.reduce({}) do |lyrics_index, (word, index)|
    lyrics_index[word] ||= {
      positions: [],
      count:     0
    }
    lyrics_index[word][:positions] << index + 1
    lyrics_index[word][:count] += 1
    lyrics_index
  end
  self.save
end



end

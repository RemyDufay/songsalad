class Song < ApplicationRecord
  has_many :game_songs
  vadilates :year, :genre, :title, :author, :lyrics, presence: true
end

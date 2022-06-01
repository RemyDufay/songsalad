class Guess < ApplicationRecord
  belongs_to :game_session
  validates :word, presence: true
end

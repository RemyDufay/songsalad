class Guess < ApplicationRecord
  belongs_to :game_session
  validates :word, :frequency, presence: true

end

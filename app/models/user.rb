class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :game_sessions
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships, source: :friend

  def allfriends
    friendships.where(status: "accepted") + Friendship.where(friend_id: self, status:"accepted")
  end
end

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :game_sessions
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships, source: :friend

  def allfriends
    allfriendships = friendships.where(status: "accepted") + Friendship.where(friend_id: self, status:"accepted")
    allfriends = allfriendships.map do |friendship|
      showedfriend = friendship.friend.name == self.name ? friendship.user : friendship.friend
    end
    allfriends << self
    return allfriends
  end

  def leaderboard
    leaderboard = {}
    self.allfriends.map do |friend|
    leaderboard[friend.name] = friend.score
    end
    return leaderboard
  end

  def score
    user = self
    sessions = GameSession.where(user_id:user)
    sessionscount = sessions.count
    songsplayed = GameSessionSong.where(game_session_id: sessions, status:"done" )
    songsplayedcount = songsplayed.count
    totalguesses = 0
    songsplayed.each do |song|
      totalguesses += song.guesses.count
    end
    averageguesses =  songsplayedcount == 0 ? 999 : totalguesses /  songsplayedcount


  end


end

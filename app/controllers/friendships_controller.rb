class FriendshipsController < ApplicationController

  def index
    @friendship = Friendship.new
    @all_users = User.pluck(:name, :id)
    


    @demands = Friendship.where(friend_id: current_user)
    @pending = @demands.where(status: "pending")


  end

  def create
    params[:friendship][:friend_id].reject(&:empty?).each do |friend_id| # ["3", "5"]
      @friendship =Friendship.new({
        user: current_user,
        friend: User.find(friend_id),
        status: "pending"
      })
      @friendship.save!
    end
    redirect_to friendships_path
  end

  # def user_index
  #   @users = User.all
  #   @search = params["search"]
  #   if @search.present?
  #     @name = @search["name"]
  #     @friend = User.where(name: @name)
  #   end
  # end

  def accept
    @friendship = Friendship.find(params[:id])
    @friendship.status = "accepted"
    @friendship.save
    redirect_to friendships_path
  end

  def decline
    @frienship = Friendship.find(params[:id])
    @friendship.status = "declined"
    @friendship.save
    redirect_to friendships_path
  end

  private

  def friendship_params
    params.require(:friendship).permit(:status, :user_id, :friend_id)
  end
end

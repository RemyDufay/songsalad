class GuessesController < ApplicationController
  def create
    @guess = Guess.new(guess_params)
    @game_session = GameSession.find(params[:id])
    @guess.game_session = @game_session
    @guess.save!
  end

  private

  def guess_params
    params.require(:guess).permit(:word, :frequency)
  end

end

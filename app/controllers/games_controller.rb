class GamesController < ApplicationController
  before_action :set_game, only: [:show]

  # GET /games/new
  def new
    @game = Game.new
  end

  # POST /games
  def create
    @game = Game.new(players: [@current_player])

    if @game.save && @game.setup
      redirect_to @game, notice: 'Game was successfully created.'
    else
      render :new
    end
  end

  # GET /games/1
  def show
    redirect_to game_round_path(@game)
  end

  # POST /games/find
  def find
    @game = Game.find_by(game_params)

    if @game
      redirect_to @game
    else
      redirect_to root_path, alert: "We couldn't find this game, are you sure it's the right code?"
    end
  end

  private

  def set_game
    @game = Game.find_by!(slug: params[:id])
  end

  # Only allow a list of trusted parameters through.
  def game_params
    params.require(:game).permit(:slug)
  end
end
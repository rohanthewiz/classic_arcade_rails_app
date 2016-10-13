class GamesController < ApplicationController
  before_action :set_game, only: [:show]

  # GET /games
  # GET /games.json
  def index
    @games = Game.order('year DESC').where(is_active: true)
                 .paginate(page: params[:page], per_page: 16)
  end

  # GET /games/1
  # GET /games/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    # def game_params
    #   params.require(:game).permit(:name, :year, :manufacturer, :notes, :is_active)
    # end
end

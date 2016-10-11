class LikesController < ApplicationController

  # POST /likes
  # POST /likes.json
  def create
    like_params_with_ip = like_params.tap do |prms|
      prms[:game_id] = prms[:game_id].to_i
      prms[:fan_ip] = request.ip
    end
    business_logic_errors = []
    if Like.where(like_params_with_ip).any?
      business_logic_errors << "We already have a like from this ip: #{request.ip}"
    else
      @like = Like.new(like_params_with_ip)
    end

    respond_to do |format|
      if business_logic_errors.empty? && @like.save
        game = @like.game # cache
        game_data = {
            name: game.name,
            year: game.year,
            publisher: game.manufacturer,
            likes: game.likes.count,
            liked_by: request.ip
        }
        LikeMailer.game_liked_email(game_data).deliver_later

        format.html { redirect_to @like, notice: 'Like was successfully created.' }
        format.json {
          render json: {
              status: :created, game_id: game.id, likes: game.likes.count
          }}
      else
        format.html { render :new }
        format.json {
          render json: (business_logic_errors.any? ? business_logic_errors : @like.errors),
                 status: :unprocessable_entity }
      end
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def like_params
      params.require(:like).permit(:game_id)
    end
end

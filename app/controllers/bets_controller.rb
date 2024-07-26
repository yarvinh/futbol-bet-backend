

class BetsController < ApplicationController


    def index 
      game = Game.find_by_id(params[:game_id])
      user = current_user
      bet = nil

      if game && user
        bet = game.bets.find_by(user_id: user.id)
      end

      if bet
        render json: BetSerializer.new(bet).to_serialized_json
      elsif user 
        render json: {}.to_json
      else
        render json: {errors_or_messages: {from: "bet_index", msg: ["Please login to bet"] }}.to_json
      end
    end

    def create
        user = current_user
        bet = Bet.create(bet_params)
        if bet.valid? && !params[:amount].include?("-") && !params[:team_id].empty?
          render json: BetSerializer.new(bet).to_serialized_json
        elsif params[:team_id].empty?
          render json: {errors_or_messages: {from: "create_bet", errors: ["Please select a valid option."] }}.to_json
        elsif params[:amount].include?("-")
            render json: {errors_or_messages: {from: "create_bet", errors: ["Please enter a valid number."] }}.to_json
        else
          render json: {errors_or_messages: {from: "create_bet", errors: bet.errors.full_messages }}.to_json
        end
    end

    private
    def bet_params
      params.require(:bet).permit(:team_id, :user_id, :amount, :game_id,)
    end
end


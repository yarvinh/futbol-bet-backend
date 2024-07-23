

class BetsController < ApplicationController
    def create
        team = Team.find_by_id(params[:team_id])
        game = Game.find_by_id(params[:game_id])
        user = current_user

        bet = Bet.create(amount: params[:amount], team: team, game: game, user: user)
        if bet.valid? && !params[:amount].include?("-")
          render json: BetSerializer.new(bet).to_serialized_json
        elsif params[:amount].include?("-")
            render json: {errors_or_messages: {from: "create_bet", errors: ["Please enter a valid number."] }}.to_json
        else
          render json: {errors_or_messages: {from: "create_bet", errors: bet.errors.full_messages }}.to_json
        end
    end
end


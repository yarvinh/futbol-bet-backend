

class BetsController < ApplicationController
    def create
        team = Team.find_by_id(params[:team_id])
        game = Game.find_by_id(params[:game_id])
        user = current_user

        if !params[:amount].include?("-") && user
            bet = Bet.new(amount: params[:amount])
            bet.team = team
            bet.game = game
            bet.user = user
            bet.save
            user.coins -=  bet.amount.to_i
            user.save
            render json: BetSerializer.new(bet).to_serialized_json
        else
            render json: {errors_or_messages: {from: "create_bet", errors: ["You are not athorize to bet", "Login or create an account"]}}
        end
       
    end
end


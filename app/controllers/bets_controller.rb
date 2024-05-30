

class BetsController < ApplicationController
    def create
        team = Team.find_by_id(params[:team_id])
        game = Game.find_by_id(params[:game_id])
        user = User.find_by_id(params[:user_id])
        
        if !params[:amount].include?("-")
            bet = Bet.new(amount: params[:amount])
            bet.team = team
            bet.game = game
            bet.user = user
            bet.save
            user.coins -=  bet.amount.to_i
            user.save
        end
        render json: GamesSerializer.new(Game.upcoming_games).to_serialized_json
    end
end


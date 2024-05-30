class GamesController < ApplicationController
 
    def show 
        game = Game.find(params[:id])
        render json:GamesSerializer.new(game).to_serialized_json
    end
    def index
        if user_id = session[:user_id]
          if User.find(user_id).admin
             @games = Game.all
            
          else
            games = Game.upcoming_games
            render json:GamesSerializer.new(games).to_serialized_json
          end
        else
            games = Game.upcoming_games
            render json:GamesSerializer.new(games).to_serialized_json
        end    
    end
    
    def new 
        if logged_in?
          user = User.find(session[:user_id])
          if User.find_by(admin: true).id === session[:user_id]
            @game = Game.new
          end
        else
            redirect_to '/login'
        end
    end

    def create
        @game =  Game.new(game_params)
        @game.time = Game.time_zone(params[:game][:date])
        @game.date = Game.date(params[:game][:date])
        @game.save

        team_1 = Team.find_by_id(game_params[:team_1])
        team_1_event = TeamEvent.new
        team_1_event.team = team_1
        team_1_event.game = @game
 
        team_1_event.save
         
        
        team_2 = Team.find(game_params[:team_2])
        team_2_event = TeamEvent.new
        team_2_event.team = team_2
        team_2_event.game = @game
        team_2_event.save

        if game_params[:competition] === 'none'
            @game.update(competition: team_1.league)
        end
        redirect_to new_game_path

    end

    def update    
        game = Game.find(params[:id])
        game.update(likes: game.likes + 1)
        render json:GamesSerializer.new(Game.upcoming_games).to_serialized_json
    end

    def destroy
        game = Game.find(params[:id])

        game.likes.each{|e|e.delete}
        game.team_events.each{|e|e.delete}
        game.comments.each{|c| 
            c.likes.each{|like|like.delete}
            c.replies.each{|r|  
              r.likes.each{|e|e.delete}
              r.delete
            }
            c.delete
          }
          
        game.team_events.each{|e|e.delete}
        game.delete
        redirect_to games_path
    end

    def close_event
        game = Game.find_by_id(params[:id])
        if game
            game.pending = false
            game.save
            game.team_events.each{|t|
              t.points = 1
              t.save
            }
        end
        game.game_bets
        redirect_to '/games'
    end

    def game_params(*args)
        params.require(:game).permit(:competition, :team_1, :team_2)
    end

end

class GamesController < ApplicationController
 
    def show 
      if current_user && current_user.admin
        @game = Game.find_by_id(params[:id])
      else
        game = Game.find(params[:id])
        render json:GameSerializer.new(game).to_serialized_json
      end
    end
    
    def index
      user = current_user
      if user && user.admin 
        @games = Game.all
      else
        games = Game.upcoming_games
        render json:GamesSerializer.new(games).to_serialized_json
      end
    end
    
    def new 
        @league = League.find_by_id(params[:league_id])
        if !@league
          @league = League.first
        end
        @user = current_user
        if current_user && current_user.admin
          @game = Game.new
        else
          redirect_to '/login'
        end
    end

    def create
        team_1 = Team.find_by_id(game_params[:team_1])  
        team_2 = Team.find(game_params[:team_2])
        @game =  Game.new(game_params)
        @league = League.find_by_id(params[:game][:league_id])

        respond_to do |format|
          if @game.valid?
            @game.save_teams(team_1,team_2)
            @game.save
            format.html { redirect_to game_path(@game), notice: "Game was successfully created." }
            format.json { render :show, status: :ok, location: @game }
          else
            format.html { render :new, status: :unprocessable_entity }
            format.json { render json: @game.errors, status: :unprocessable_entity }
          end
        end

    end

    def edit
      @game = Game.find_by_id(params[:id])
      @league = League.find_by_id(params[:league_id])
      if !@league
        @league = @game.league
      end
     
    end

    def update 
        team_1 = Team.find_by_id(game_params[:team_1])  
        team_2 = Team.find(game_params[:team_2])
        @game = Game.find(params[:id])
        @game.team_events.each{|team_event| team_event.delete}
        @game.save_teams(team_1,team_2)
      if current_user.admin && @game && @game.update(game_params)
        redirect_to game_path(@game)
      elsif current_user.admin && @game
        @league = League.find_by_id(params[:game][:league_id])
        render :edit, from: "edit", status: :unprocessable_entity
      else
        @game.update(likes: game.likes + 1)
        render json:GamesSerializer.new(Game.upcoming_games).to_serialized_json
      end
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
    private

    def league
      @league = League.find_by_id(params[:league_id])
      if !@league
        @league = League.first
      end
    end

    def game_params(*args)
        params.require(:game).permit(:competition, :team_1, :team_2, :league_id, :date, :time, :league_id)
    end

end

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
      raise params.inspect
        @league = league
        @game =  Game.new(game_params)
        @game.time = !params[:game][:date].empty? && Game.time_zone(params[:game][:date])
        @game.date = !params[:game][:date].empty? && Game.date(params[:game][:date])
        @game.league = league
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

        respond_to do |format|
          if @game.valid?
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
    private

    def league
      @league = League.find_by_id(params[:league_id])
      if !@league
        @league = League.first
      end
    end

    def game_params(*args)
        params.require(:game).permit(:competition, :team_1, :team_2, :league_id)
    end

end

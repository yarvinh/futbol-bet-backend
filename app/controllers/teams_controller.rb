class TeamsController < ApplicationController
   def show
      @team = Team.find_by_id(params[:id])
      if !admin
         render json:TeamSerializer.new(@team).to_serialized_json 
      end
   end

   def index
      @teams = Team.all
      if admin
         @leagues = League.all
      elsif params[:league_id] != "all"
         league = League.find_by_id(params[:league_id])
         render json:TeamsSerializer.new(league.teams).to_serialized_json 
      else
         @teams = Team.all
         render json:TeamsSerializer.new(@teams).to_serialized_json 
      end   
   end

   def search_league_teams
      @search_league = League.find_by_id(params[:league_id])
      @game = Game.find_by_id(params[:game_id]) 
      if @game 
         redirect_to edit_game_path(@game, league_id: @search_league.id, help: true)   
      else
         @game = Game.new
         redirect_to new_game_path(league_id: @search_league.id, help: true) 
      end    
   end

   def edit
      @team = Team.find_by_id(params[:id])
   end

   def new
      user = current_user
      if user && user.admin
         @team = Team.new
      else
         redirect_to :teams_new
      end
   end

   def update
      @team = Team.find_by_id(params[:id])
      if params[:team][:league_id]
        Tournament.create({team_id: @team.id, league_id: params[:team][:league_id]})
      end

      if @team.update(team_params)
         redirect_to team_path(@team), notice: "Team was successfully updated." 
      else
        render :new ,status: :unprocessable_entity 
      end
   end

   def create
      @league = League.find_by_id(params[:team][:league_id])
      
      user = current_user
      @team = Team.new(team_params)
      @team.save 
      Tournament.create({league_id: params[:team][:league_id], team_id: @team.id})
      if !@league
         @team.add_error("can't be black")
         render :new, status: :unprocessable_entity 
      elsif @team.valid? && @league
         redirect_to league_path(@league), notice: "Team was successfully created." 
      elsif @team.valid?
        redirect_to team_path(@team), notice: "Team was successfully created." 
      elsif params[:team][:league_id]
         render "/leagues/show", status: :unprocessable_entity 
      else
         render :new, status: :unprocessable_entity 
      end
   end

   def destroy 
      team = Team.find_by_id(params[:id])
      team.delete
      redirect_to teams_path, notice: "Team was successfully destroyed." 
   end

   private
   def team_params
      params.require(:team).permit(:fc, :league, :stadium, :logo_url)
   end
end

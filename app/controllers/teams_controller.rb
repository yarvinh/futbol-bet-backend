class TeamsController < ApplicationController
   def show
      @team = Team.find_by_id(params[:id])
   end

   def index
        @teams = Team.all
        if admin
         @team
        else
         render json:TeamsSerializer.new(@teams).to_serialized_json 
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
      if @team.valid? && @league
         redirect_to league_path(@league), notice: "Team was successfully created." 
      elsif @team.valid?
        redirect_to team_path(@team), notice: "Team was successfully created." 
      elsif params[:team][:league_id]
         render "/leagues/show", status: :unprocessable_entity 
      else
         render :new, status: :unprocessable_entity 
      end
   end

   private
   def team_params
      params.require(:team).permit(:fc, :league, :stadium, :logo_url)
   end
end

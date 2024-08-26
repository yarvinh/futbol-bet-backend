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

   def new
      user = current_user
      if user && user.admin
         @team = Team.new
      else
         redirect_to :teams_new
      end
   end

   def create
      user = current_user
      @team = Team.new(team_params)
      if @team.save
        redirect_to team_path(@team), notice: "Team was successfully created." 
      else
         render :new, status: :unprocessable_entity 
      end
   end

   private
   def team_params
      params.require(:team).permit(:fc, :league, :stadium, :logo_url)
   end
end

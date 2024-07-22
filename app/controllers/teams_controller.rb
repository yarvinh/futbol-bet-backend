class TeamsController < ApplicationController
   def index
        @teams = Team.all
        if admin
         @team
        else
         render json:TeamsSerializer.new(@teams).to_serialized_json 
        end      
   end
end

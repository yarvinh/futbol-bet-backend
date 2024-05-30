class TeamsController < ApplicationController
   def index
        teams = Team.all
        render json:TeamsSerializer.new(teams).to_serialized_json       
   end
end

class TeamEventsController < ApplicationController
    def index
      @teams = Team.all
    end
    def update
    
        event = TeamEvent.find_by_id(params[:id])
        game =  event.game
        game.update_attribute(:pending, false)
        game.update_attribute(:status, "finished")
        event.points += 3
        event.save
        game.game_bets
        redirect_to '/games'
    end

    def reset_event
        game = Game.find_by_id(params[:game_id])
        if game
          game.update_attribute(:pending, true)
          game.update_attribute(:status, "pending")
          game.status = nil
          game.team_events.each{|event|
            event.points = 0
            event.save
          }
        end

        redirect_to '/games'    
    end

end

class TeamEventsController < ApplicationController
    def update
        event = TeamEvent.find_by_id(params[:id])
        game =  event.game
        game.pending = false
        event.points += 3
        game.save
        event.save
        game.game_bets
        redirect_to '/games'
    end

    def reset_event
        game = Game.find_by_id(params[:game_id])
        if game
          game.pending = true
          game.save
          game.team_events.each{|event|
            event.points = 0
            event.save
          }
        end

        redirect_to '/games'    
    end

end

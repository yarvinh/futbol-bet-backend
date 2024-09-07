class GameSerializer

    def initialize(game)
      Game.ninety_minutes
       @game = game
    end

    def to_serialized_json
      options = {
        include: {
          league: {},
          team_events: {
            include:{
              team: {}
            }
          },
          teams: {},
          likes: {}
        },
   
        except: [:updated_at, :created_at]
      }
      @game.to_json(options)
    end
  
  end
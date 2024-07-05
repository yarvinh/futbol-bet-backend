class GameSerializer

    def initialize(game)
      Game.ninety_minutes
       @game = game
    end

    def to_serialized_json
      options = {
        include: {
          team_events: {
            include:{
              team: {}
            }
          },
          teams: {},
          likes: {},
          
          bets: {
            include: {
              user: {},
              team: {}
            }
          },
          
          comments_by_date: {
            include:{
              user: {},
              replies_by_date: {
                include: {
                  likes: {},
                  user: {}
              }
            }
          }
          }      
        },
   
        except: [:updated_at, :created_at]
      }
      @game.to_json(options)
    end
  
  end
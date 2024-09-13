class TeamSerializer
    def initialize(team)
       @team = team
    end

  def to_serialized_json
      options = {
        except: [:updated_at, :created_at],
        include: {
          games: {
            include:{
              league: {},
              teams: {},
              bets: {}
            }
          }
        }
      }
      @team.to_json(options)
    end
  
  end
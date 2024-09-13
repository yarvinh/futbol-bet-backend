class TeamSerializer
    def initialize(team)
       @team = team
    end

  def to_serialized_json
      options = {
        except: [:updated_at, :created_at],
        include: [:games]
      }
      @team.to_json(options)
    end
  
  end
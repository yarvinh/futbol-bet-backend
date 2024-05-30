class TeamsSerializer
    def initialize(user_object)
       @team = user_object
    end

  def to_serialized_json
      options = {
   
        except: [:updated_at, :created_at]
      }
      @team.to_json(options)
    end
  
  end
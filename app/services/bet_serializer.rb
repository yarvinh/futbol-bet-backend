class BetSerializer
    def initialize(bet)
       @bet = bet
    end

  def to_serialized_json
      options = {
        include: {
          team: {}
        }
      }
      @bet.to_json(options)
    end
  
  end
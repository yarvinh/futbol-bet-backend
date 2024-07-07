class LikesSerializer
    def initialize(likes)
       @likes = likes
    end

  def to_serialized_json
       options = {
      }
      @likes.to_json(options)
    end
  
  end
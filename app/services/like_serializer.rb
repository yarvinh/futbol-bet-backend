class LikeSerializer
    def initialize(like)
       @like = like
    end

  def to_serialized_json
       options = {
      }
      @like.to_json(options)
    end
  
  end
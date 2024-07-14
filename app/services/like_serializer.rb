class LikeSerializer
    def initialize(like)
       @like = like
    end

  def to_serialized_json
       options = {
        include: {
          reply: { 
            only: [:comment_id,:user_id]
          }
        }
      }
      @like.to_json(options)
    end
  
  end
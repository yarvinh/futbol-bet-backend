class CommentSerializer
    def initialize(comment)
        @comment = comment
    end

    def to_serialized_json
        options = {
            include: {
            user: {},
            likes: {},
            replies_by_date: {
              include: {
                likes: {},
                user: {}
              }
            }
            }
        }
       @comment.to_json(options)
    end
end
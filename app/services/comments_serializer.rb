class CommentsSerializer
    def initialize(comments)
        @comments = comments
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
       @comments.to_json(options)
    end
end
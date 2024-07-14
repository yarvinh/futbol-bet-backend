class RepliesSerializer
    def initialize(replies)
        @replies = replies
    end

    def to_serialized_json
        options = {
            include: {
                comment: {
                    # only: [:comment_id]
                },
                user: {},
                likes: {},
            }
        }
       @replies.to_json(options)
    end
end
class RepliesSerializer
    def initialize(replies)
        @replies = replies
    end

    def to_serialized_json
        options = {
            include: [:comment, :user, :likes]
        }
       @replies.to_json(options)
    end
end
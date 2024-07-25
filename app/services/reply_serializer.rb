class ReplySerializer
    def initialize(reply)
        @reply = reply
    end

    def to_serialized_json
        options = {
            include: [:user,:likes]
        }
       @reply.to_json(options)
    end
end
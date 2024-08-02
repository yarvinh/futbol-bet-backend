class ReplySerializer
    def initialize(reply)
        @reply = reply
    end

    def to_serialized_json
        options = {
            include: {
                user: {},
                likes: {},
                images: {
                    methods: :image_url
                }
            }
        }
       @reply.to_json(options)
    end
end
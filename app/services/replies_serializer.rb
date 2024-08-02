class RepliesSerializer
    def initialize(replies)
        @replies = replies
    end

    def to_serialized_json
        options = {
            include: {
                comment: {}, 
                user: {}, 
                likes:{},
                images: {
                    methods: :image_url
                }
            }   
        }
       @replies.to_json(options)
    end
end
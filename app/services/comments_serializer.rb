class CommentsSerializer
    def initialize(comments)
        @comments = comments
    end

    def to_serialized_json

        options = {
            include: {
                user:{},
                likes:{},
                images: {
                    methods: :image_url
                }
            },
            methods: :replies_total
        }
       @comments.to_json(options)
    end
end
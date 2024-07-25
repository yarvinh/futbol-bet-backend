class CommentsSerializer
    def initialize(comments)
        @comments = comments
    end

    def to_serialized_json

        options = {
            include: [:user,:likes],
            methods: :replies_total
        }
       @comments.to_json(options)
    end
end
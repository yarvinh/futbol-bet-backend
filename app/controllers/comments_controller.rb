class CommentsController < ApplicationController
    def index
        comments = Comment.all
        render json: {comment: comments}
    end


    def create
        game = Game.find(params[:game_id])
        user = User.find(params[:user_id])

        comment = Comment.new(comment: params[:comment])
        comment.game = game
        comment.user = user
        comment.save
        render json:GameSerializer.new(game).to_serialized_json
    end

    def destroy
        comment = Comment.find_by(id: params[:id])
        game = comment.game
        if comment
          comment.replies.each{|e|
            e.likes.each{|like|
              like.delete
            }
          }
          comment.replies.each{|e|e.delete}
          comment.likes.each{|e|e.delete}
          comment.delete
      end
      if game
        render json:GameSerializer.new(game).to_serialized_json
      else
        render json:{errors_or_messages: {from: "delete_comment", errors: ["comment don't exist"]}}.to_json
      end
    end
  

end

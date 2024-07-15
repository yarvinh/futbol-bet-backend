class CommentsController < ApplicationController
    def index
      comments_length = params[:comments_length].to_i
      game = Game.find_by_id(params[:game_id])
      comments = game.comments_by_date
      render json:CommentsSerializer.new(comments[comments_length .. comments_length + 9]).to_serialized_json
    end

    def create
        game = Game.find(params[:game_id])
        user = current_user
        if user 
          comment = Comment.new(comment: params[:comment])
          comment.game = game
          comment.user = user
          comment.save
          render json:CommentSerializer.new(comment).to_serialized_json
        else
          render json: {errors_or_messages:{from: "create_comment", errors: ["Create an account or signin to comment"]}}.to_json
        end
    end

    def destroy
        comment = Comment.find_by(id: params[:id])
        game = comment.game
        if comment && current_user
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
        render json:{comment_removed: true}.to_json
      else
        render json:{errors_or_messages: {from: "delete_comment", errors: ["comment don't exist"]}}.to_json
      end
    end
  

end

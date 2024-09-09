class CommentsController < ApplicationController
    def index
      comments_length = params[:comments_length].to_i
      game = Game.find_by_id(params[:game_id])
      
      if game
        comments = game.comments_by_date
        render json:CommentsSerializer.new(comments[comments_length .. comments_length + 9]).to_serialized_json
      else
        render json: {errors_or_messages:{from: "comments", errors: ["No comments were found matching this game"]}}.to_json, status: :unprocessable_entity 
      end
    end

    def create
        comment = Comment.create(comment_params)
        if params[:images]
          comment.create_images(params[:images], current_user.id)
        end
        if comment && comment.valid? 
          render json:CommentSerializer.new(comment).to_serialized_json
        else
          render json: {errors_or_messages:{from: "create_comment", errors: ["An Error occurred while creating comment."]}}.to_json, status: :unprocessable_entity 
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
        comment.images.each{|e|e.destroy}
        comment.replies.each{|e|e.delete}
        comment.likes.each{|e|e.delete}
        comment.delete
      end
      if game
        render json:{comment_removed: true}.to_json
      else
        render json:{errors_or_messages: {from: "delete_comment", errors: ["An Error occurred. comment was not deleted"]}}.to_json, status: :unprocessable_entity 
      end
    end

    private
    def comment_params
      params.require(:comment).permit(:comment, :user_id, :game_id)
    end
    
  

end

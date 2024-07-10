class RepliesController < ApplicationController
    def index 
      game = Game.find_by_id(params[:game_id])
      comment = game && game.find_by_id(:comment_id)
      if comment 
        render json:RepliesSerializer.new(comment.replies_by_date).to_serialized_json
      else
        render json: {errors_or_messages: {from: "replies", error:["No replies were found."]}}.to_json
      end
    end

    def create
        user = User.find_by_id(params[:user_id])
        comment = Comment.find_by_id(params[:comment_id])
        game = comment.game
        if user && comment
          reply = Reply.new(reply: params[:reply])
          # reply.game = game
          reply.user = user
          reply.comment = comment
          reply.save
        end
        render json:GameSerializer.new(game).to_serialized_json
    end
    
    def destroy
        reply = Reply.find_by_id(params[:id])
        game = replyreply.comment.game
        if reply
          reply.likes.each{|e|e.delete}
          reply.delete
        end
        games = Game.all
        render json:GameSerializer.new(game).to_serialized_json
    end
end

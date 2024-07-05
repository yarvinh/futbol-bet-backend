class RepliesController < ApplicationController
    def create
        user = User.find_by_id(params[:user_id])
        comment = Comment.find_by_id(params[:comment_id])
        game = comment.game
        if user && comment
          reply = Reply.new(reply: params[:reply])
          reply.user = user
          reply.comment = comment
          reply.save
        end
        render json:GameSerializer.new(game).to_serialized_json
    end
    
    def destroy
        reply = Reply.find_by_id(params[:id])
        game = reply && reply.comment.game
        if reply
          reply.likes.each{|e|e.delete}
          reply.delete
        end
        games = Game.all
        render json:GameSerializer.new(game).to_serialized_json
    end
end

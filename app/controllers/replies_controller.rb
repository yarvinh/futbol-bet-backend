class RepliesController < ApplicationController
    def create
        user = User.find_by_id(params[:user_id])
        comment = Comment.find_by_id(params[:comment_id])
        if user && comment
          reply = Reply.new(reply: params[:reply])
          reply.user = user
          reply.comment = comment
          reply.save
        end
        render json:GamesSerializer.new(Game.upcoming_games).to_serialized_json
    end
    
    def destroy
        reply = Reply.find_by_id(params[:id])
        if reply
          reply.likes.each{|e|e.delete}
          reply.delete
        end
        games = Game.all
        render json:GamesSerializer.new(Game.upcoming_games).to_serialized_json
    end
end

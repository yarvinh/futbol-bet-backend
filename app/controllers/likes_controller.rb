class LikesController < ApplicationController
    def create
      @user = User.find(params[:user_id])
      like = Like.new()
      like.user = @user
      game = Game.find_by(id: params[:game_id])
      comment = Comment.find_by(id: params[:comment_id])
      reply = Reply.find_by(id: params[:reply_id])
      if game && !game.likes.find_by(user_id: params[:user_id])  
       like.game = game
       like.save
       likes = game.likes.size
       game.likes_total = likes
       game.save
      elsif comment && !comment.likes.find_by(user_id: params[:user_id])  
        like.comment = comment
        like.save
      elsif reply && !reply.likes.find_by(user_id: params[:user_id]) 
        like.reply = reply
        like.save
      end
    render json:GamesSerializer.new(Game.upcoming_games).to_serialized_json
    end

    def destroy
      if params[:game_id] || params[:comment_id] || params[:reply_id]
        like = Like.find_by(id: params[:id])
        if like
          like.delete
        end
      end
      render json:GamesSerializer.new(Game.upcoming_games).to_serialized_json
    end

end

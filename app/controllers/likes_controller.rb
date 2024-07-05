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
        like.game = game
        like.comment = comment
        like.save
      elsif reply && !reply.likes.find_by(user_id: params[:user_id]) 
        like.game = game
        like.reply = reply
        like.save
      end
    render json:LikesSerializer.new(game.likes).to_serialized_json
    end

    def destroy
      like = Like.find_by_id(params[:id])
      game = like.game
      if params[:game_id] || params[:comment_id] || params[:reply_id]
        if like
          like.delete
        end
      end
      if game
       render json:LikesSerializer.new(game.likes).to_serialized_json
      else
        render json: {logged_in: false, status: 401, errors_or_messages: { from: "delete_like", errors: ["This like don't exist."] }}
      end
    end

end

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
    render json:LikeSerializer.new(like).to_serialized_json
    end

    def destroy
      like = current_user.likes.find_by_id(params[:id])
      if like
        like.delete
        render json:{like_removed: true}
      else
        render json: {like_removed: false, logged_in: false, status: 401, errors_or_messages: { from: "delete_like", errors: ["This like don't exist."] }}.to_json
      end
    end

end

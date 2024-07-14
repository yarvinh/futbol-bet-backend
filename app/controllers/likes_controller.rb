class LikesController < ApplicationController
    def create
      @user = User.find(params[:user_id])
      like = Like.new()
      like.user = @user
      game = Game.find_by_id(params[:game_id])
      comment = Comment.find_by_id(params[:comment_id])
      reply = Reply.find_by_id(params[:reply_id])
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
      like = current_user && current_user.likes.find_by_id(params[:id])
      
      if like
        like.delete
        comment_id = like.comment && like.comment.id || like.reply && like.reply.comment_id 
        render json:{like_removed: true,comment_id: comment_id, game_id: like.game_id, reply_id: like.reply_id}
      else
        render json: {like_removed: false, logged_in: false, status: 401, errors_or_messages: { from: "delete_like", errors: ["This like don't exist."] }}.to_json
      end
    end

end

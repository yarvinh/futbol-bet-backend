class LikesController < ApplicationController
    def create
      @user = current_user
      like = Like.create(user: @user, game_id: params[:game_id], comment_id: params[:comment_id],reply_id: params[:reply_id])
      if like.valid?
        render json:LikeSerializer.new(like).to_serialized_json
      else
        render json:{ errors_or_messages: { from: "create_like" , errors: like.errors.full_messages} }.to_json
      end
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

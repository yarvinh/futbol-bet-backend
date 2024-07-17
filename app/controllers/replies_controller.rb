class RepliesController < ApplicationController
    def index 
      array_length = params[:array_length]
      game = Game.find_by_id(params[:game_id])
      comment = game && game.comments.find_by_id(params[:comment_id])
      # raise array_length.to_i.inspect
      if comment 
        render json:RepliesSerializer.new(comment.replies_by_date[array_length.to_i ..array_length.to_i + 10 ]).to_serialized_json
      else
        render json: {errors_or_messages: {from: "replies", error:["No replies were found."]}}.to_json
      end
    end

    def create
        # user = User.find_by_id(params[:user_id])
        user = current_user
        comment = Comment.find_by_id(params[:comment_id])
        game = comment.game
        if user && comment
          reply = Reply.new(reply: params[:reply])
          reply.user = user
          reply.comment = comment
          reply.save
        end
        render json:ReplySerializer.new(reply).to_serialized_json
    end
    
    def destroy
        user = current_user
        reply = user && user.replies.find_by_id(params[:id])
        # raise user.inspect
        # raise reply.inspect
        if user && reply
          reply.likes.each{|e|e.delete}
          reply.delete
          render json:{reply_removed: true, reply_id: params[:id].to_i, comment_id: params[:comment_id].to_i }.to_json
        else
          render json: {errors_or_messages: {from: 'delete_reply', errors: ["You are not authorize to delete this reply"]}}.to_json
        end
    end
end

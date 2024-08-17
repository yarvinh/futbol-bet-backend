class RepliesController < ApplicationController
    def index 
      array_length = params[:array_length].to_i
      game = Game.find_by_id(params[:game_id])
      comment = game && game.comments.find_by_id(params[:comment_id])
      if comment 
        render json:RepliesSerializer.new(comment.replies_by_date[array_length .. array_length.to_i + 10 ]).to_serialized_json
      else
        render json: {errors_or_messages: {from: "reply", errors:["No replies were found."]}}.to_json, status: :unprocessable_entity 
      end
    end

    def create
        user = current_user
        reply = Reply.create(reply_params)
        if params[:images]
          reply.create_images(params[:images], user.id)
        end
        
        if reply.valid? 
          render json:ReplySerializer.new(reply).to_serialized_json
        else
          render json: {errors_or_messages: {from: "create_reply", errors:["Reply couldn't be created", "Please refresh browser and try again."]}}.to_json, status: :unprocessable_entity 
        end
        
    end
    
    def destroy
        user = current_user
        reply = user && user.replies.find_by_id(params[:id])
        if user && reply
          reply.images.each{|e|e.delete}
          reply.likes.each{|e|e.delete}
          reply.delete
          render json:{reply_removed: true, reply_id: params[:id].to_i, comment_id: params[:comment_id].to_i }.to_json
        else
          render json: {errors_or_messages: {from: 'delete_reply', errors: ["You are not authorize to delete this reply"]}}.to_json, status: :unprocessable_entity 
        end
    end
    private
    def reply_params
      params.require(:reply).permit(:reply, :user_id, :comment_id, :game_id)
    end
end

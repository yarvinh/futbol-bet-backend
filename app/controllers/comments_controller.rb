class CommentsController < ApplicationController
    def index
        comments = Comment.all
        render json: {comment: comments}
    end


    def create
        game = Game.find(params[:game_id])
        user = User.find(params[:user_id])

        comment = Comment.new(comment: params[:comment])
        comment.game = game
        comment.user = user
        comment.save
        games = Game.all
        render json:GamesSerializer.new(games).to_serialized_json
    end

    def destroy
        comment = Comment.find_by(id: params[:id])
        if comment
          comment.replies.each{|e|
            e.likes.each{|like|
              like.delete
            }
          }
          comment.replies.each{|e|e.delete}
          comment.likes.each{|e|e.delete}
          comment.delete
      end
        render json:GamesSerializer.new(Game.upcoming_games).to_serialized_json
      end
  

end

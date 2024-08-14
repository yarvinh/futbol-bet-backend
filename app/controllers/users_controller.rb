class UsersController < ApplicationController

    def home
        @user = User.first 
      end

      def show  
        if current_user && current_user
          @user = current_user
        else
          redirect_to '/login'
        end
      end
  
      def new 
         @user = User.new
      end
  
      def create  
        @user = User.create(user_params)
        if @user.valid? && @user.admin
          redirect_to '/sessions/new'
        elsif @user && @user.admin
          flash[:error] = @user.errors.full_messages 
          redirect_to "/users/new"
        elsif @user.valid? 
          token = login!
          render json: {logged_in: true, token: token, user: @user}.to_json
        else
          render json: {logged_in: false , errors_or_messages:{from: "create_user", errors: @user.errors.full_messages }}.to_json, status: 401
        end
      end

      def update 
        user  = current_user
        if user && user.update(user_params)
          render json: {logged_in: true, user: user, errors_or_messages: {from: "update_user" ,msg: ["User was succesfully updated"]}}.to_json
        elsif(user)
          render json: {logged_in: true, user: user, errors_or_messages: {from: "update_user" ,errors: user.errors.full_messages}}.to_json, status: :unprocessable_entity 
        else
          render json: {logged_in: false, errors_or_messages: {from: "update_user" ,errors: ["You are not authorize to edit this user."]}}.to_json, status: 401
        end
      end

      private
      def user_params
		    params.require(:user).permit(:name, :password, :password_confirmation, :username, :email, :coins, :address, :admin)
      end
end


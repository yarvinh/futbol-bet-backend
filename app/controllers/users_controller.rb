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
        # raise params.inspect
        if @user.valid? && @user.admin
          login!
          redirect_to '/'
        elsif @user && @user.admin
          render :new, status: :unprocessable_entity 
        elsif @user.valid? 
          token = login!
          render json: UserSerializer.new({logged_in: true, token: token, user: @user, errors_or_messages:{from:"create_user", msg: ["Welcome #{@user.name}"] } }).to_serialized_json
        else
          render json: {logged_in: false , errors_or_messages:{from: "create_user", errors: @user.errors.full_messages }}.to_json, status: 401
        end
      end

      def update 
        user  = current_user
        if user && user.update(user_params)
          render json:UserSerializer.new({logged_in: true, user: user, errors_or_messages: {from: "update_user" ,msg: ["User was succesfully updated"]}}).to_serialized_json
        elsif user
          render json: {errors_or_messages: {from: "update_user" ,errors: user.errors.full_messages}}.to_json, status: :unprocessable_entity 
        else
          render json: {logged_in: false, errors_or_messages: {from: "update_user" ,errors: ["You are not authorize to edit this user."]}}.to_json, status: 401
        end
      end

      private
      def user_params
		    params.require(:user).permit(:name, :password, :password_confirmation, :username, :email, :coins, :address, :admin)
      end
end


class UsersController < ApplicationController

    def home
        @user = User.first 
      end

      def show  
        # raise current_user.inspect
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
      # when there is no admin
        if user_params[:admin] && !User.find_by(admin: true)
          @user = User.new(user_params)
            if @user.valid?
               @user.save
               redirect_to '/sessions/new'
             else
              flash[:error] = @user.errors.full_messages 
               redirect_to "/users/new"
            end  
        else 
          @user = User.new(user_params)
          if @user.valid?
            @user.save
            login!
            render json: {logged_in: true, user: @user }
          else
             render status: 200, json: { logged_in: false , errors_or_messages:{from: "create_user", errors: @user.errors.full_messages }}
          end
        end
      end

      def update 
        user  = current_user
        if user && user.update(user_params)
          render json: {logged_in: true, user: user, errors_or_messages: {from: "update_user" ,msg: ["User was succesfully updated"]}}
        elsif(user)
          render json: {logged_in: true, user: user, errors_or_messages: {from: "update_user" ,errors: user.errors.full_messages}}
        else
          render json: {logged_in: false, errors_or_messages: {from: "update_user" ,errors: ["You are not authorize to edit this user."]}}
        end
      end

      private
      def user_params
		    params.require(:user).permit(:name, :password, :password_confirmation, :username, :email, :coins, :address, :admin)
      end
end


class UsersController < ApplicationController

    def home
        @user = User.first 
      end

      def show  
        if session[:user_id].to_s == params[:id].to_s
          @user = User.find(params[:id])
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
             render status: 200, json: { logged_in: false , messages: @user.errors.full_messages }
          end
        end
      end

      def update 
        user_info = params[:user][:user_info]
        user = User.find(params[:user][:user_id])
        name = user_info[:name]
        email = user_info[:new_email]
        email_confirmation = user_info[:email_confirmation]


        if user_info[:update_type] === 'password'
            user.old_password = user_info[:old_password]
            if user.valid? && user.update(password: user_info[:new_password])
             render json: { saved: 'Password was updated', email: '', name: ''}
            elsif
              render json: { error_messages: user.errors.full_messages[0], email: '', name: ''}
            end
        elsif user_info[:update_type] === 'name' && !name.empty?
          user.update(name: name)
          render json: { saved: 'Name was updated', email: '', password: ''}
        elsif user_info[:update_type] === 'email' 
          if !email.empty?  && email === email_confirmation
              user.update(email: email)
              render json: { saved: 'Email was updated', password: '', name: ''}
          elsif
            render json: {error_messages: 'Email confirmation doesnt match' , password: '', name: ''}
          end
        else
          render json: { error_messages: 'Empty input', name: '', password: '', email: ''}
        end
  
      end

      private
      def user_params
		    params.require(:user).permit(:name, :password, :password_confirmation, :username, :email, :coins, :address, :admin)
      end
end


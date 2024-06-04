class SessionsController < ApplicationController

    def show
        if logged_in? 
            user = User.find(session[:user_id])
            render json: {logged_in: true, user: user}
        else
            render json: {logged_in: false, errors_or_messages: {from: "login", errors: ['No user, please login or signup' ]}}
       end

    end  
    def new
        if logged_in?
            user = User.find(session[:user_id])
            redirect_to user_path(user)
        else
            render "new"
        end
    end

    def create  
        @user = User.find_by(username: params[:user][:username])
        if @user && @user.authenticate(params[:user][:password])
            login!
            if @user.admin
              redirect_to user_path(@user)
            else    
               render json: {logged_in: true, user: @user }
            end
        else
            redirect_to "/adminlogin"
        end   
    end

    def login
        @user = User.find_by(username: params[:user][:username])
        if @user && @user.authenticate(params[:user][:password])
            login!  
            render json: {logged_in: true, user: @user }
        else
            render json: {logged_in: false, status: 401, errors_or_messages: { from: "login", errors: ['wrong password or username'] }}
        end  

    end
  
    def destroy
        session.clear
        redirect_to "/login"
    end

    def log_out
        session.clear
        render status: 200, json: { logged_in: false , error_or_messages: { from: "logout", msg: ["logout succesfull "] }}
    end
end

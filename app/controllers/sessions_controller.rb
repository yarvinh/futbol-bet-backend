class SessionsController < ApplicationController

    def show
        user = User.find_by_id(session[:user_id])
        if logged_in? 
            user = current_user
            render json: {logged_in: true, user: user}.to_json
        else
            render json: {logged_in: false, errors_or_messages: {from: "show_login", errors: ['No user, please login or signup' ]}}.to_json
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
            token = login!
            if @user.admin
              redirect_to user_path(@user)
            else    
               render json: {logged_in: true, user: @user , token: token}
            end
        else
            redirect_to "/adminlogin"
        end   
    end

    def login
        @user = User.find_by(username: params[:user][:username])
        if @user && @user.authenticate(params[:user][:password])
            token = login!  
            render json: {logged_in: true, user: @user, token: token }
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
        render status: 200, json: { logged_in: false , errors_or_messages: { from: "logout", msg: ["logout succesfull "] }}
    end
end

class SessionsController < ApplicationController

    def show
        if current_user && current_user.admin
            @user = current_user
        elsif logged_in? 
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
        end
         
        if @user.admin
            redirect_to user_path(@user)
        elsif current_user  
            render json: {logged_in: true, user: @user , token: token}
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

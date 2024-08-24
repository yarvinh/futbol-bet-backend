class SessionsController < ApplicationController

    def show
        if admin
            @user = current_user
        elsif logged_in? 
            user = current_user
            render json: UserSerializer.new({logged_in: true, user: user}).to_serialized_json
        else
            render json: {logged_in: false, errors_or_messages: {from: "show_login", errors: ['No user, please login or signup' ]}}.to_json, status: 401
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
            render json: UserSerializer.new({logged_in: true, user: @user , token: token}).to_serialized_json
        else
            redirect_to "/adminlogin"
        end  

    end

    def login
        @user = User.find_by("username = ?",params[:user][:username])
        if @user && @user.authenticate(params[:user][:password])
            token = login!  
            render json: UserSerializer.new({logged_in: true, user: @user, token: token }).to_serialized_json
        else
            render json: {logged_in: false, errors_or_messages: { from: "login", errors: ['wrong password or username'] }}.to_json, status: 401
        end  
    end
  
    def destroy
        session.clear
        redirect_to "/login"
    end

    def log_out
        session.clear
        render status: 200, json: { logged_in: false , errors_or_messages: { from: "logout", msg: ["logout succesfull "] }}.to_json
    end
end

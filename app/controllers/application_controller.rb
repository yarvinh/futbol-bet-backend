# require 'jwt'
class ApplicationController < ActionController::Base
    skip_before_action :verify_authenticity_token
    helper_method :login!, :logged_in?, :current_user, :authorized_user?, :logout!
    before_action :current_user
    # def login!
    #     session[:user_id] = @user.id
    # end

    def login!
        if @user
            payload = {:user_id => "user_#{@user.id}"}
            JWT.encode payload  , 'testin_key'  , 'HS256'
        end  
    end

    def token 
        headers = request.headers['Authorization']
        
        authorization = headers && headers.split(" ")[1]
        begin 
          JWT.decode authorization, 'testin_key', true, { algorithm: 'HS256' }
        rescue JWT::DecodeError
          false
        end
    end

    # def valid_secret_key(user)
    #     headers = request.headers['Authorization']
    #     secret_key = headers && headers.split(" ")[2]
    #     if user && user.authenticators.find_by("secret_key=?",secret_key)
    #         secret_key 
    #     else
    #         false
    #     end
    # end

    def logged_in?
        if token
            token[0]['user_id']
        end
    end

    def current_user
         user = User.find_by_id(logged_in?.split('_')[1]) if logged_in? 
        #  if valid_secret_key(user)
        #     user
        #  end
    end

    # def checking_session
    #     if password_session_token && password_session_token[0]['password_code'] || token && token[0]['email_code']
    #         password_session_expires
    #     end
    # end



    # def logged_in?
    #     !!User.find_by_id(session[:user_id])
    # end

    # def current_user
    #     @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id] 
    # end
    



    def authorized_user?
         @user == current_user
    end

    def logout!
         session.clear
    end
end


class ApplicationController < ActionController::Base
    skip_before_action :verify_authenticity_token
    helper_method :login!, :logged_in?, :current_user, :authorized_user?, :logout!
    

    def login!
        if @user && @user.admin
            session[:user_id] = @user.id
        elsif @user
            payload = {:user_id => "user_#{@user.id}"}
            JWT.encode payload,secret_key, 'HS256'
        end  
    end

    def token 
        headers = request.headers['Authorization']
        authorization = headers && headers.split(" ")[1]
        begin 
          JWT.decode authorization, secret_key, true, { algorithm: 'HS256' }
        rescue JWT::DecodeError
          false
        end
    end

    def logged_in?
        if token
            token[0]['user_id']
        end
    end

    def current_user
        if logged_in? 
          User.find_by_id(logged_in?.split('_')[1]) 
        else
            User.find_by_id(session[:user_id])
        end
    end

    def admin
        current_user && current_user.admin
    end

    def authorized_user?
         @user == current_user
    end

    def logout!
         session.clear
    end

    private
    def secret_key 
        "sbhsbsrubvhursbvhusbvhubrshuvbshuvbhbchbfj-vrivndiubvudbvurbvubuhvvb"
        # Rails.application.credentials.dig(:web_token, :secret_key)
    end
end

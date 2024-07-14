class ApplicationController < ActionController::Base
    skip_before_action :verify_authenticity_token
    helper_method :login!, :logged_in?, :current_user, :authorized_user?, :logout!
    before_action :current_user
    def login!
        session[:user_id] = @user.id
      end

    def logged_in?
        !!User.find_by_id(session[:user_id])
    end

    def current_user
        @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id] 
    end
    



    def authorized_user?
         @user == current_user
    end

    def logout!
         session.clear
    end
end

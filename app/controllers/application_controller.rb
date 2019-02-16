class ApplicationController < ActionController::Base
    helper_method :current_user, :sign_in, :sign_out

    def current_user
        if session[:user_id]
            @current_user||= User.find(session[:user_id])
        else
            @current_user = nil
        end
    end

    def sign_in(user)
        session[:user_id] = user.id 
    end

    def sign_out
        session[:user_id] = nil
    end
end

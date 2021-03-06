module SessionsHelper
    def log_in(user)
        session[:user_id] = user.id
    end
    
    def current_user
        @current_user ||= User.find_by(id: session[:user_id])
    end
    
    def logged_in?
        !current_user.nil?
    end
    
    def is_admin?
        current_user.is_admin
    end
    
    def log_out
        session.delete(:user_id)
        @current_user = nil
    end
    
    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
    
    def logged_in_admin
      unless logged_in? && is_admin?
        flash[:session] = "Only Admins are allowed to see this page."
        redirect_to root_url
      end
    end
end

#RSpec.configure do |config|
#    config.include SessionsHelper
#end
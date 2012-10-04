class ApplicationController < ActionController::Base
  
  protect_from_forgery
  
  helper_method :current_user

  private

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id]) if User.find(session[:user_id]).confirmed == true
    else
      nil
    end
  end

end

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  helper_method :loggedin?, :current_user
  
  def loggedin?
    !!session[:user_id]
  end
  
  def current_user
    Chef.find(session[:user_id]) if session[:user_id]
  end
  
  def require_logged_in
    if !loggedin?
      flash[:warning] = "Only logged in users are allowed to see this page."
      redirect_to login_path
    end
  end
  
end

class AppController < ActionController::Base
  protected
  def auth_user
  	unless session[:user_id]
  		redirect_to(:controller => 'sessions', :action => 'login')
  		return false
    end
    @current_user = user_profile.find session[:user_id] 
  	return true
  end

  # prevents user from signup/logging in without first logging out of the original session
  def req_user_logout
    if session[:user_id]
            redirect_to(:controller => 'sessions', :action => 'home')
      return false
    end
    return true
  end
end

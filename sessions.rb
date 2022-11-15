class Sessions < ApplicationController
 
	before_filter :authenticate_user, :except => [:login, :login_attempt, :logout]
	before_filter :save_login_state, :only => [:login, :login_attempt]

	def login
		is_auth = User_profile.auth(params[:username_or_email],params[:login_password])
		if is_auth
			session[:user_id] = is_auth.id
			flash[:notice] = "Welcome, #{is_auth.username}"
			redirect_to(:action => 'home')
		else
			flash[:notice] = "Failed login attempt"
        	flash[:color]= "Failed login attempt"
			render "login"
		end
	end

	def logout
		session[:user_id] = nil
		redirect_to :action => 'login'
	end
end

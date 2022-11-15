 class UserController < AppController

  before_filter :save_login_state, :only => [:new_user]

   def new_user
    	@user = User_profile.new(params[:user])
    	if @user.save
    		flash[:notice] = "Account created successfully"
      else
        flash[:notice] = "Failed to create account"
      end
      render "new_user"
    end
end

class SessionsController < ApplicationController
	def new
		@user = User.new
	end

	def create
		user = User.find_by(username: session_params[:username])
    if user.try(:authenticate, session_params[:password])
      session[:user_id] = user.id
      flash[:message] = "You succesfully logged in"
      redirect_to root_path
    else
      flash[:error] = "User not found, please login"
      redirect_to login_path
    end
	end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  private
  
  def session_params
    params.require(:session).permit(:username, :password)
  end
end
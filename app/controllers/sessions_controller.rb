class SessionsController < ApplicationController
	def new
		@user = User.new
	end

	def create
		user = User.find_by(username: params[:user][:username])
    if user
      session[:user_id] = user.id
      redirect_to root_path
    else
      flash[:error] = "Unable to find password & username combination"
      redirect_to login_path
    end
	end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
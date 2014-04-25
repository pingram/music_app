class SessionsController < ApplicationController
	def new
		render :new
	end

	def create
		@user = User.find_by_credentials(
			user_params["email"],
			user_params["password"])
		if @user.nil?
			flash.now[:errors] = ["Either username or password is incorrect"]
			render :new
		else
			log_in_user!(@user)
			redirect_to user_url(@user)
		end
	end

	private

	def user_params
		params.require(:user).permit(:email, :password)
	end
end

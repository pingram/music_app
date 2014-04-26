class SessionsController < ApplicationController
	skip_before_action :require_login_and_activated, only: [:new, :create, :destroy]

	helper_method :current_user

	def new
		# XXX redirect users that are already logged in
		render :new
	end

	def create
		@user = User.find_by_credentials(
			user_params["email"],
			user_params["password"])
		if @user.nil?
			flash.now[:errors] = ["Either username or password is incorrect"]
			render :new
		elsif @user.activated = false
			flash.now[:errors] = ["User has not been activated, new activation token sent."]
			UserMailer.activation_email(@user).deliver!
			render :new
		else
			log_in_user!(@user)
			redirect_to user_url(@user)
		end
	end

	def destroy
		logout_current_user!
		redirect_to new_session_url
	end

	private

	def user_params
		params.require(:user).permit(:email, :password)
	end
end

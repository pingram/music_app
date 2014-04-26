class UsersController < ApplicationController
	skip_before_action :require_login_and_activated, only: [:new, :create, :activate]

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		@user.activation_token = User.generate_token
		if @user.save
			UserMailer.activation_email(@user).deliver!
			redirect_to new_session_url
		else
			flash.now[:errors] = @user.errors.full_messages
			render :new
		end
	end

	def activate
		@user = User.find_by_activation_token(params[:activation_token])
		@user.activated = true
		log_in_user!(@user)
		redirect_to :root
	end

	def index
		@users = User.all
	end

	def show
		@user = User.find(params[:id])
	end

	private

	def user_params
		params.require(:user).permit(:email, :password, :activation_token, :activated)
	end

end

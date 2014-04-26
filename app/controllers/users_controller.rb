class UsersController < ApplicationController
	skip_before_action :require_login, only: [:new, :create]

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		@user.activation_token = User.generate_token
		UserMailer.activation_email(@user).deliver!
		if @user.save
			fail
			log_in_user!(@user)
			redirect_to user_url(@user)
		else
			flash.now[:errors] = @user.errors.full_messages
			render :new
		end
	end

	def index
		@users = User.all
	end

	def show
		@user = User.find(params[:id])
	end

	private

	def user_params
		params.require(:user).permit(:email, :password)
	end

end

class UsersController < ApplicationController
	skip_before_action :require_login, only: [:new, :create]

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		@user.activation_token = User.generate_token
		# fail

		p @user.valid?
		p @user

		if @user.save
			# log_in_user!(@user)
			UserMailer.activation_email(@user).deliver!
			redirect_to new_session_url
		else
			flash.now[:errors] = @user.errors.full_messages
			#XXX come back to figure out why this isn't working
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
		params.require(:user).permit(:email, :password, :activation_token, :activated)
	end

end

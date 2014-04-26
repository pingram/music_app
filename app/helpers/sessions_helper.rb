module SessionsHelper

	def current_user
		return nil if session[:token].nil?
		@current_user ||= User.find_by_token(session[:token])
	end

	def current_user=(user)
		@current_user = user
		session[:token] = user.token
	end

	def logged_in?
		!!current_user
	end

	def log_in_user!(user)
		user.token = User.generate_token
		user.save!
		self.current_user = user
	end

	def logout_current_user!
		current_user.reset_token!
		session[:token] = nil
	end
end
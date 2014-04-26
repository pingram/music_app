class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include SessionsHelper

  before_action :require_login_and_activated

  private

  def require_login_and_activated
  	unless logged_in? && current_user.activated
      flash[:error] = "You must be logged in to access this section"
      redirect_to new_session_url
    end
  end
end

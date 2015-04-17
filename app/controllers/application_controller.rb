class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def authenticate_user_is_admin
    unless current_user.admin?
      redirect_to root_path, alert: "You are not authorized to access that!"
    end
  end
end

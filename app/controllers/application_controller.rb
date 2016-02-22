class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private
    def authenticate_admin
      unless current_user.id == 1
        flash[:error] = "未授权的访问"
        redirect_to root_url
      end
    end
end

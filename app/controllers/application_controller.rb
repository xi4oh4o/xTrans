class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource)
    dashboard_tunnels_path
  end

  private
    def authenticate_admin
      unless current_user.id == 1
        flash[:error] = "未授权的访问"
        redirect_to root_url
      end
    end
end

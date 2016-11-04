class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def authenticate_active_admin_user!
    authenticate_user!
    unless current_user.role?(:admin)
      flash[:alert] = "You are not authorized to access this resource!"
      redirect_to root_path
    end
  end

  rescue_from CanCan::AccessDenied, with: :record_not_found
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def record_not_found
    render file: "#{Rails.root}/public/404.html",  :status => 404
  end
end

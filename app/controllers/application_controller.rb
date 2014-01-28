class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end  

   protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:acount_update) { |u| u.permit(:email, :password, :password_confirmation, :name, :avatar) }
  end
end

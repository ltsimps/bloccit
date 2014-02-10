class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end  

   def after_sign_in_path_for(resource)
    topics_path
   end  

   protected

  def configure_permitted_parameters
    [:sign_up, :account_update].each do |x|
      [:avatar, :name].each do |y|
        devise_parameter_sanitizer.for(x) << y
      end
    end
  end
end

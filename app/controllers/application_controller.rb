class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  layout :layout_by_resource


  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = exception.message
    redirect_to(:back)

  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_in) {|u| u.permit(:signin,:username, :email, :password, :remember_me)}
    devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:email, :username, :password, :password_confirmation, :fname, :lname, :username, :bdate)}
  end

  def layout_by_resource
    if devise_controller?
      'devise'
    else
      'application'
    end
  end

  def after_sign_in_path_for(resource)
    root_path
  end

end

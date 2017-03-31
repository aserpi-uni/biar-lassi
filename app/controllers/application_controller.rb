class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    added_attrs = [:username, :email, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

  def after_sign_in_path_for(resource)
    user_path resource
  end

  def current_user
    current_admin || current_consumer || current_employee
  end

  def user_path(user)
    if user.is_a? Admin
      admin_path user
    elsif user.is_a? Consumer
      consumer_path user
    elsif user.is_a? Employee
      employee_path user
    end
  end
end

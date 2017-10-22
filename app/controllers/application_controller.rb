class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  helper_method :current_user
  helper_method :bootstrap_class_for

  protected

  def configure_permitted_parameters
    added_attrs = [:username, :email, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
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

  private

  def user_not_authorized
    if current_user
      flash[:alert] = I18n.t :forbidden
      redirect_to user_path current_user
    else
      response.headers['Status-Code'] = '403'
      render file: '/public/403.html', layout: false
    end
  end

  def bootstrap_class_for(flash_type)
    case flash_type
    when 'success'
      'alert-success' # Green
    when 'error'
      'alert-danger' # Red
    when 'alert'
      'alert-warning' # Yellow
    when 'notice'
      'info' # Blue
    else
      flash_type.to_s
    end
  end
end

# TODO: capire perché enterprise.errors ed employee.errors a volte non funzionano.
# Problema universale o solo di Firefox?

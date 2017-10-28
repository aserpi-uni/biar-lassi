class ApplicationController < ActionController::Base
  include Pundit

  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from Pundit::NotAuthorizedError, with: :not_authorized

  helper_method :current_user


  # TODO: create Devise controllers when not present
  # TODO: include Accessible module in all Devise controllers


  protected

  # Permits the parameters needed by Devise controllers.
  def configure_permitted_parameters
    added_attrs = [:username, :email, :password, :password_confirmation]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end


  # Returns the current user.
  def current_user
    current_admin || current_consumer || current_employee
  end

  # Returns the path of the user.
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

  # Redirects the user after a _Pundit_ nay.
  def not_authorized
    flash[:error] = I18n.t :forbidden
    response.headers['Status-Code'] = '403'
    redirect_to root_path
  end

end

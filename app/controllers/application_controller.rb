class ApplicationController < ActionController::Base
  include Pundit

  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from Pundit::NotAuthorizedError, with: :not_authorized

  helper_method :current_user
  helper_method :comment_path
  helper_method :user_path
  helper_method :vote_resource_path

  protected

  # Permits the parameters needed by Devise controllers.
  def configure_permitted_parameters
    added_attrs = %i[username email password password_confirmation]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

  # Path of a comment
  def comment_path(comment)
    "/#{comment.domain.class.name.underscore.pluralize}/#{comment.domain.id}#comments/#{comment.id}"
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

  def vote_resource_path(resource)
    send("up_#{resource.class.name.underscore}_path", resource)
  end

  private

  # Redirects the user after a _Pundit_ nay.
  def not_authorized
    flash[:error] = I18n.t :forbidden
    response.headers['Status-Code'] = '403'
    redirect_to root_path
  end
end

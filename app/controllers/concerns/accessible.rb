module Accessible
  extend ActiveSupport::Concern

  private

  def authorize_user
    authorize :devise, :standard
  end

  def user_not_authorized
    if current_user
      redirect_to user_path current_user
    else
      response.headers['Status-Code'] = '403'
      render file: '/public/403.html', layout: false
    end
  end
end

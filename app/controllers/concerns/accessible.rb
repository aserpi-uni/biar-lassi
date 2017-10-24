module Accessible
  extend ActiveSupport::Concern

  private

  def authorize_user
    authorize :devise, :standard
  end

  def user_not_authorized
    redirect_to user_path current_user
  end
end

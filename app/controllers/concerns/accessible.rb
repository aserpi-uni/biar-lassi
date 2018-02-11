# Policies that can be included in a +before_action+ method.
module Accessible
  extend ActiveSupport::Concern

  private

  # Front end to the standard Devise policy.
  def authorize_user
    authorize :devise, :standard
  end

  def not_authorized
    redirect_to(current_admin ? current_admin : root_path)
  end
end

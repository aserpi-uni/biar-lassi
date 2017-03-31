module Accessible
  extend ActiveSupport::Concern

  protected

  def redirect_user
    if current_user
      redirect_to user_path current_user
    end
  end
end

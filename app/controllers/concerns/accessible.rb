module Accessible
  extend ActiveSupport::Concern

  protected

  def check_user
    flash.clear
    if current_admin or current_consumer or current_employee
      redirect_to('/') && return
    end
  end
end

module Accessible
  extend ActiveSupport::Concern

  protected

  def check_user
    flash.clear
    if current_admin
      redirect_to admin_path current_admin
    elsif current_consumer
      redirect_to consumer_path current_consumer
    elsif current_employee
      redirect_to employee_path current_employee
    end
  end
end

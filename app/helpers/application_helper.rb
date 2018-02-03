# Global helpers.
module ApplicationHelper
  # Converts Rails flash message types into Bootstrap message types.
  def bootstrap_class_for(flash_type)
    case flash_type
    when 'success'
      'alert-success' # Green
    when 'error'
      'alert-danger' # Red
    when 'alert'
      'alert-warning' # Yellow
    when 'notice'
      'alert-info' # Blue
    else
      flash_type.to_s
    end
  end

  # Paths

  def edit_path(usr)
    if usr.is_a? Admin
      edit_admin_path usr
    elsif usr.is_a? Consumer
      edit_consumer_registration_path
    elsif usr.is_a? Employee
      edit_employee_path usr
    end
  end

  end
end

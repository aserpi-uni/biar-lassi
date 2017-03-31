Devise::Models::Recoverable::ClassMethods.class_eval do
  def send_reset_password_instructions(attributes = {})
    recoverable = find_or_initialize_with_error_by(:email, attributes[:email], :not_found)
    recoverable = find_or_initialize_with_error_by(:username, attributes[:username], :not_found) unless recoverable.persisted?
    recoverable.send_reset_password_instructions if recoverable.persisted?
    recoverable
  end
end

# Mailer for operations on users.
class UserMailer < ApplicationMailer
  default from: 'no-reply@tesi.com'

  def new_email(user)
    @user = user
    mail to: @user.email
  end
end

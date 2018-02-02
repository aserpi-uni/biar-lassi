# Mailer for operations on users.
class UserMailer < ApplicationMailer
  default from: 'no-reply@tesi.com'

  def new_email(user)
    @user = user
    mail subject: I18n.t('user_mailer.new_email.subject'), to: @user.email
  end
end

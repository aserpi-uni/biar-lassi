# Groups all OmniAuth callbacks for the Consumer model.
class Consumers::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # OmniAuth callback for Facebook
  def facebook
    authorize :facebook, :facebook?
    auth = request.env['omniauth.auth']

    return connect_current(auth) if current_consumer

    @consumer = Consumer.find_by(provider: auth.provider, uid: auth.uid) and
      return already_existing(@consumer)

    # Can't accept the email if it has already been used by a non-Consumer account
    @email_taken = Admin.find_by(email: auth.info.email) || Employee.find_by(email: auth.info.email) and
      return render 'auth/consumers/facebook/connect'

    if !auth.info.email.nil? && (@consumer = Consumer.find_by(email: auth.info.email))
      @consumer.facebook_connect(auth)
      flash[:success] = I18n.t(:connected, scope: [:facebook])
      sign_in_and_redirect @consumer, event: :authentication
    else
      session['devise.facebook_data'] = auth
      render 'auth/consumers/facebook/connect'
    end
  end

  # :nocov:
  # Redirects the user when an error occurs.
  def failure
    flash[:error] = I18n.t :failure, scope: [:facebook]
    redirect_to root_path
  end
  # :nocov:

  private

  # Signs in the user that has these Facebook credential.
  def already_existing(consumer)
    sign_in_and_redirect consumer, event: :authentication
    set_flash_message(:notice, :success, kind: 'Facebook') if is_navigational_format?
  end

  # Updates the current account with these Facebook credentials.
  def connect_current(auth)
    current_consumer.facebook_connect(auth)

    flash[:success] = I18n.t(:connected, scope: [:facebook])
    redirect_to edit_registration_path(current_user)
  end
end

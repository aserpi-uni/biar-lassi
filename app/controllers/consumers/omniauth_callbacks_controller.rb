class Consumers::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def facebook
    authorize :facebook, :facebook?
    auth = request.env['omniauth.auth']

    # :nocov:
    # Impossible to test accurately
    if current_consumer
      current_consumer.provider = auth.provider
      current_consumer.uid = auth.uid
      current_consumer.save validate: false
      flash[:success] = I18n.t :connected, scope: [:facebook]
      redirect_to user_path(current_user)
      return
    end
    # :nocov:

    @email_taken = Admin.find_by(email: auth.info.email) || Employee.find_by(email: auth.info.email)

    @consumer = Consumer.find_by provider: auth.provider, uid: auth.uid
    if @consumer.nil?
      @consumer = auth.info.email.nil? ? nil : Consumer.find_by(email: auth.info.email)
      if @consumer.nil?
        session['devise.facebook_data'] = auth
        render 'consumers/facebook/connect'
      else
        @consumer.provider = auth.provider
        @consumer.uid = auth.uid
        @consumer.save
        sign_in_and_redirect @consumer, event: :authentication
      end

    else
      sign_in_and_redirect @consumer, event: :authentication # this will throw if @consumer is not activated
      set_flash_message(:notice, :success, kind: 'Facebook') if is_navigational_format?
    end
  end

  # :nocov:
  # Impossible to test
  def failure
    redirect_to root_path
  end
  # :nocov:
end

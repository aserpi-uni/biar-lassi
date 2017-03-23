class Consumers::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    consumer = Consumer.find_by provider: request.env['omniauth.auth'].provider, uid: request.env['omniauth.auth'].uid

    if consumer.nil?
      consumer = consumer.email.nil? ? nil : Consumer.find_by email: consumer.email
      if consumer.nil?
        session['devise.facebook_data'] = request.env['omniauth.auth']
        redirect_to 'consumers/registrations/facebook_connect'
      else
        consumer.provider = request.env['omniauth.auth'].provider
        consumer.uid = request.env['omniauth.auth'].uid
        consumer.save!
        sign_in_and_redirect consumer, :event => :authentication
      end
    else
      sign_in_and_redirect consumer, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => 'Facebook') if is_navigational_format?
    end

    def failure
      redirect_to root_path
    end
  end
end

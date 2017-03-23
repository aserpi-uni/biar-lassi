class Consumers::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    auth = request.env['omniauth.auth']
    consumer = Consumer.find_by provider: auth.provider, uid: auth.uid

    if consumer.nil?
      consumer = if auth.info.email.nil? then nil else Consumer.find_by(email: auth.info.email) end
      if consumer.nil?
        session['devise.facebook_data'] = auth
        render 'consumers/facebook/connect'
      else
        consumer.provider = auth.provider
        consumer.uid = auth.uid
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

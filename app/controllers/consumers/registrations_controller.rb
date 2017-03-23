class Consumers::RegistrationsController < Devise::RegistrationsController
  include Accessible

  before_action :check_user
# before_action :configure_sign_up_params, only: [:create]
# before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

  def facebook_connect
  end

  def facebook_connect_existing
    @consumer = Consumer.find_by username: params[:username]
    if @consumer.nil? or not @consumer.valid_password? params[:password]
      flash.now[:error] = 'Incorrect username or password'
      render 'facebook_connect'
    else
      @consumer.provider = session['devise.facebook_data'].provider
      @consumer.uid = session['devise.facebook_data'].uid
      @consumer.save!
      sign_in_and_redirect @consumer
    end
  end

  def facebook_select_username_form
    if Consumer.find_by(username: params[:username]).nil?
      @consumer = Consumer.from_omniauth! session['devise.facebook_data'], params[:username]
      sign_in_and_redirect @consumer
    else
      flash.now[:error] = 'Username already taken'
      render 'facebook_connect'
    end

  end
end

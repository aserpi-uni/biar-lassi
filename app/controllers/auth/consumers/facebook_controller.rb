# Sign in with and disconnect a Facebook account.
class Auth::Consumers::FacebookController < ApplicationController

  # Connects a Facebook account with an existing account when a user logs in.
  def connect_existing
    authorize :facebook
    @consumer = Consumer.find_by username: params[:username]
    if @consumer.nil? || !@consumer.valid_password?(params[:password])
      flash.now[:alert] = t :incorrect_credentials
      render :connect and return
    end
    @consumer.connect_facebook(session['devise.facebook_data'])
    flash[:success] = I18n.t(:connected, scope: [:facebook])
    session.delete 'devise.facebook_data'
    sign_in_and_redirect @consumer
  end


  # Removes the Facebook info from the +current_user+'s account.
  def disconnect
    authorize :facebook
    current_consumer.provider = nil
    current_consumer.uid = nil
    current_consumer.save
    flash[:success] = I18n.t(:disconnected, scope: [:facebook])
    redirect_to edit_registration_path(current_consumer)
  end


  # Creates a new account from the Facebook info and the parameters inserted through a form.
  # If the email is provided manually it must be confirmed before accessing the site.
  def select_username
    authorize :facebook
    @consumer = Consumer.from_omniauth(session['devise.facebook_data'], params[:username],
                                       params[:email], params[:password],
                                       params[:password_confirmation])
    @consumer.save or
      return render :connect

    session.delete 'devise.facebook_data'
    flash[:success] = I18n.t :connected, scope: [:facebook]
    sign_in_and_redirect @consumer
  end
end

class Consumers::FacebookController < ApplicationController

  def connect_existing
    authorize :facebook
    @consumer = Consumer.find_by username: params[:username]
    if @consumer.nil? || !@consumer.valid_password?(params[:password])
      flash.now[:error] = t(:incorrect_credentials)
      render 'connect'
    else
      @consumer.provider = session['devise.facebook_data']['provider']
      @consumer.uid = session['devise.facebook_data']['uid']
      @consumer.save
      session.delete 'devise.facebook_data'
      sign_in_and_redirect @consumer
    end
  end

  def disconnect
    authorize :facebook
    current_consumer.provider = nil
    current_consumer.uid = nil
    current_consumer.save validate: false
    flash[:notice] = I18n.t(:success, scope: [:facebook])
    redirect_to consumer_path current_consumer
  end

  def select_username
    authorize :facebook
    @consumer = Consumer.from_omniauth session['devise.facebook_data'], params[:username], params[:email]
    session.delete 'devise.facebook_data'
    flash['notice'] = I18n.t :password_notice,
                             link: view_context.link_to('here', '/consumers/edit'),
                             pwd: @consumer.password
    sign_in_and_redirect @consumer
  rescue ActiveRecord::RecordInvalid => e
    flash.now[:error] = e.message
    render 'connect'
  end
end

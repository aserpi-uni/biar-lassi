class Consumers::FacebookController < ApplicationController
  include Accessible
  before_action :redirect_user, except: :disconnect


  def connect_existing
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
    if current_consumer.email.blank?
      flash[:error] = I18n.t(:no_email, scope: [:facebook]) # it is not possible to reach this point without tiping manually a link
    else
      current_consumer.provider = nil
      current_consumer.uid = nil
      current_consumer.save validate: false
      flash[:notice] = I18n.t(:success, scope: [:facebook])
    end
    redirect_to consumer_path current_consumer
  end

  def select_username
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

class WelcomeController < ApplicationController
  include Accessible

  before_action :authorize_user

  def index; end
end

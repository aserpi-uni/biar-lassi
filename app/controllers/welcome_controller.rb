class WelcomeController < ApplicationController
  include Accessible
  before_action :redirect_user

  def index
  end

  def consumer
  end

  def enterprise
  end
end

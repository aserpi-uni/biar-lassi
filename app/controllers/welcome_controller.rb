class WelcomeController < ApplicationController
  include Accessible

  before_action :authorize_user

  # TODO: rivedere un po' tutto

  def index; end

  def consumer; end

  def enterprise; end
end

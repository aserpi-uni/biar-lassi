class WelcomeController < ApplicationController
  include Accessible

  before_action :authorize_user
  # TODO: rivedere un po' tutto

  def index
    @post = current_user.posts.build if logged_in?
  end

  def consumer
    @post = current_user.posts.build if logged_in?
  end

  def enterprise
  end
end

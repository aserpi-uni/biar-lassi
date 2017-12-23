class WelcomeController < ApplicationController
  include Accessible

  before_action :authorize_user

  def index
    @post = current_user.posts.build if logged_in?
  end

  def consumer
    @post = current_user.posts.build if logged_in?
  end
  def index; end

  def consumer; end

  def enterprise; end
end

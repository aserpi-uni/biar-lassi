class ConsumersController < ApplicationController
  def index; end

  def show
    @consumer = Consumer.find_by! username: params[:username]
    #@post = current_user.posts.build if logged_in?
    @posts = @consumer.posts.paginate(page: params[:page])
  end
end

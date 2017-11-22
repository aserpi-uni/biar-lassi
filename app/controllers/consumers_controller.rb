class ConsumersController < ApplicationController
  def index; end

  def show
    @consumer = Consumer.find_by! username: params[:username]
    @posts = @consumer.posts.paginate(page: params[:page])
  end
end

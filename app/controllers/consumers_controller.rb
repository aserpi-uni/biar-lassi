class ConsumersController < ApplicationController
  before_action :find_consumer
  def index
  end

  def show
    #@consumer = Consumer.find_by! username: params[:username]
    #@post = current_user.posts.build if logged_in?
    #@posts = @consumer.posts.paginate(page: params[:page])
    @feed_items = @consumer.feed.paginate(page: params[:page]).order(created_at: :desc)
  end

  def following
    @title = "Following"
    #@consumer  = Consumer.find_by! id: params[:id]
    @problem_threads = @consumer.following.paginate(page: params[:page])
    render 'show_follow'
  end



  private
  def find_consumer
    @consumer = Consumer.find_by! username: params[:username]
  end

end

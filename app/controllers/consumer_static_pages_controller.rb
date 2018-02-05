class ConsumerStaticPagesController < ApplicationController
  def home
    if logged_in?
      @feed_items = current_user.feed.paginate(page: params[:page]).order(created_at: :desc)
    end
  end

  def help
  end
end

class PostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "Post created!"
      redirect_to user_static_page_home_url
    end

  end


  def destroy
    @post.destroy
    flash[:success] = "Post detroyed!"
    redirect_to root_url

  end

  private

  def post_params
    params.require(:post).permit(:content)

  end

  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    redirect_to root_url if @post.nil?
  end
end
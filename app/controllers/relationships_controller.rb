class RelationshipsController < ApplicationController
  def create
    problem_thread = ProblemThread.find(params[:followed_id])
    current_user.follow(problem_thread)
    redirect_to product_problem_thread_path(problem_thread.product, problem_thread)
  end

  def destroy
    problem_thread = Relationship.find(params[:id]).followed
    current_user.unfollow(problem_thread)
    redirect_to product_problem_thread_path(problem_thread.product, problem_thread)
  end
end

class CommentPolicy < ApplicationPolicy
  attr_reader :user, :comment

  def initialize(user, comment)
    @user = user
    @comment = comment
  end

  def new?
    ((@user.is_a?(Consumer) && @user != @comment.problem_thread.author) || referent?(@user, @comment)) &&
      !@comment.problem_thread.comments.collect(&:author).include?(@user)
  end

  def create?
    (@comment.problem_thread.comments.count { |c| c.author == @user } == 1) &&
      ((@user.is_a?(Consumer) && @user != @comment.problem_thread.author) || referent?(@user, @comment))
  end

  def update?
    @user.is_a?(Admin) ||
      @user == @comment.author
  end

  def mark?
    (@user == @comment.problem_thread.author) || referent?(@user, @comment)
  end

  private

  def referent?(user, comment)
    user == comment.problem_thread.employee
  end
end

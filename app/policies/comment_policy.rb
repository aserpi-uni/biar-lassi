# frozen_string_literal: true
class CommentPolicy < ApplicationPolicy
  attr_reader :user, :comment

  def initialize(user, comment)
    @user = user
    @comment = comment
  end

  def create?
    ((@user.is_a?(Consumer) && @user != @comment.domain.author) ||
      (@user.is_a?(Employee) &&
        (@comment.domain.is_a?(AdviceThread) ||
        (@comment.domain.is_a?(ProblemThread) && referent?(@user, @comment))))) &&
      @comment.domain.product.active &&
      @comment.domain.comments.where(author: @user).empty?
  end

  def update?
    (@user.is_a?(Admin) || @user == @comment.author) &&
      @comment.domain.product.active
  end

  def down?
    @user &&
      Pundit.policy(@user, @comment.domain).show? &&
      @user != @comment.author &&
      @comment.down_votes.where(downer: @user).empty?
  end

  def down_votes?
    Pundit.policy(@user, @comment.domain).show?
  end

  def mark?
    @comment.domain.is_a?(ProblemThread) &&
      ((@user == @comment.domain.author) || referent?(@user, @comment)) &&
      @comment.domain.product.active
  end

  def up?
    @user &&
      Pundit.policy(@user, @comment.domain).show? &&
      @user != @comment.author &&
      @comment.up_votes.where(upper: @user).empty?
  end

  def permitted_attributes
    %i[content]
  end

  private

  def referent?(user, comment)
    user == comment.domain.employee
  end
end

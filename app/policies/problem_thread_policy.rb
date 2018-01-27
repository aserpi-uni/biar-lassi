class ProblemThreadPolicy < ApplicationPolicy
  attr_reader :user, :problem_thread

  def initialize(user, problem_thread)
    @user = user
    @problem_thread = problem_thread
  end

  def index?
    show?
  end

  def show?
    !@user.is_a?(Employee) ||
      @user.enterprise == @problem_thread.product.enterprise
  end

  def create?
    @user.is_a?(Consumer)
  end

  def update?
    @user.is_a?(Admin)
  end

  def destroy?
    @user.is_a?(Admin) ||
      @user == @problem_thread.consumer ||
      @user == @problem_thread.employee
  end

  def follow?
    @user.is_a?(Consumer)
  end

  # def reopen?
  #   @problem_thread.product.active? &&
  #     (@user.is_a?(Admin) ||
  #       @user == @problem_thread.consumer ||
  #       (@user.is_a?(Employee) && @user.enterprise == @problem_thread.product.enterprise))
  # end

  def permitted_attributes
    %i[content title]
  end
end

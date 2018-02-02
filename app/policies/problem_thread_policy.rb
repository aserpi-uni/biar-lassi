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
    @user.is_a?(Admin) ||
      @user == @problem_thread.author
  end

  def destroy?
    @user.is_a?(Admin) ||
      @user == @problem_thread.author ||
      @user == @problem_thread.employee
  end

  def follow?
    @user.is_a?(Consumer)
  end


  def permitted_attributes
    %i[content title]
  end
end

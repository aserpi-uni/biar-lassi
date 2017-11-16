class AdminPolicy < ApplicationPolicy
  attr_reader :admin, :user

  def initialize(user, admin)
    @user = user
    @admin = admin
  end

  def new?
    create?
  end

  def create?
    @user.is_a? Admin
  end

  def edit?
    update?
  end

  def update?
    @user.is_a? Admin
  end

  def destroy?
    @user.is_a? Admin
  end

  def lock?
    @user.is_a? Admin
  end

  def unlock?
    @user.is_a?(Admin) && @user != @admin
  end
end

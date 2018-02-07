class AdminPolicy < ApplicationPolicy
  attr_reader :admin, :user

  def initialize(user, admin)
    @user = user
    @admin = admin
  end

  def create?
    @user.is_a? Admin
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

  def manual_unlock?
    lock? && @user != @admin
  end
end

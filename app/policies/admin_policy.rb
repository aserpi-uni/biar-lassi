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
end

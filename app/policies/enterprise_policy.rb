class EnterprisePolicy < ApplicationPolicy
  attr_reader :user, :enterprise

  def initialize(user, enterprise)
    @user = user
    @enterprise = enterprise
  end

  def show?
    !@user.is_a?(Employee) ||
      @user.enterprise == @enterprise
  end

  def create?
    @user.is_a? Admin
  end

  def update?
    @user.is_a?(Admin) ||
      (@user.is_a?(Employee) &&
        @user.enterprise == @enterprise &&
        @user.supervisor?) &&
        @enterprise.active?
  end

  def destroy?
    @user.is_a? Admin
  end
end

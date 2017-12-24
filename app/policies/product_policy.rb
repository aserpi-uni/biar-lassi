class ProductPolicy < ApplicationPolicy
  attr_reader :user, :product

  def initialize(user, product)
    @user = user
    @product = product
  end

  def new?
    create?
  end

  def create?
    @user.is_a?(Employee) && @user.supervisor?
  end

  def edit?
    update?
  end

  def update?
    @user.is_a?(Admin) ||
      (create? && @user.enterprise == @product.enterprise)
  end

  def destroy?
    update?
  end

  def restore?
    update? && @product.enterprise.active?
  end

  class Scope < Scope
    def resolve
      if user.is_a? Employee
        scope.where(enterprise: user.enterprise)
      else
        scope.all
      end
    end
  end
end

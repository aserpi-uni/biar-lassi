class EmployeePolicy < ApplicationPolicy
  attr_reader :employee, :user

  def initialize(user, employee)
    @user = user
    @employee = employee
  end

  def new?
    create?
  end

  def create?
    @user.is_a?(Admin) ||
      (@user.is_a?(Employee) && @user.supervisor?)
  end

  def edit?
    update?
  end

  def update?
    @user.is_a?(Admin) ||
      (@user.is_a?(Employee) && @user.enterprise == @employee.enterprise && @employee.supervisor?)
  end

  def destroy?
    @user.is_a?(Admin) ||
      (@user.is_a?(Employee) && @user.enterprise == @employee.enterprise && @employee.supervisor?)
  end

  def lock?
    @user.is_a?(Admin) ||
      (@user.is_a?(Employee) && @user.enterprise == @employee.enterprise && @employee.supervisor?)
  end

  def unlock?
    @user.is_a?(Admin) ||
      (@user.is_a?(Employee) &&
        @user.enterprise == @employee.enterprise &&
        @employee.supervisor? &&
        @user != @admin)
  end
end

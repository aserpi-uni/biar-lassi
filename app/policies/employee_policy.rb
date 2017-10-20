class EmployeePolicy < ApplicationPolicy
  attr_reader :employee, :user

  def initialize(user, employee)
    @user = user
    @employee = employee
  end

  def new?
    @user.is_a?(Admin) || (@user.is_a?(Employee) && @user.supervisor?)
  end

  def create?
    @user.is_a?(Admin) || (@user.is_a?(Employee) && @user.supervisor?)
  end
end
class EmployeesController < ApplicationController
  def show
    @employee = Employee.find_by! username: parmas[:username]
  end
end

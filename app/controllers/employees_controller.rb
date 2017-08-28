class EmployeesController < ApplicationController
  def show
    @employee = Employee.find_by! username: params[:username]
  end
end

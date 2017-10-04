class EmployeesController < ApplicationController
  def show
    @employee = Employee.find_by! username: params[:username]
  end

  def new
    authorize Employee
    @employee = Employee.new
  end

  def create
    authorize Employee
    params = employee_params_create
    params[:enterprise] = current_employee ? current_consumer.enterprise : Enterprise.find_by(name: params[:enterprise])
    @employee = Employee.create_new(params)
    if @employee.save
      redirect_to employee_path @employee
    else
      render :new
    end
  end
end

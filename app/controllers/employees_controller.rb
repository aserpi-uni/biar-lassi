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
    params[:enterprise] = current_employee ? current_employee.enterprise : Enterprise.find_by(name: params[:enterprise])
    if params[:enterprise].nil?
      @employee = Employee.new
      @employee.errors.add(:enterprise, I18n.t(:nonexistent_enterprise))
      render :new
      return
    end
    @employee = Employee.create_new(params)
    if @employee.save
      redirect_to employee_path @employee
    else
      render :new
    end
  end


  private

  def employee_params_create
    params.require(:employee).permit(:username, :email, :role, :password, :password_confirmation, :enterprise)
  end
end

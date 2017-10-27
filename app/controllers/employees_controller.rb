class EmployeesController < ApplicationController
  def show
    @employee = Employee.find_by! username: params[:username]
  end

  def new
    authorize Employee
    @employee = Employee.new
    @employee.enterprise = Enterprise.find_by(name: session['enterprise.created']) if session.key? 'enterprise.created'
  end

  def create
    authorize Employee
    params = employee_params_create
    params[:enterprise] = current_employee.enterprise.name if current_employee

    @employee = Employee.create_new(params)
    return render :new unless @employee.save

    flash[:success] = I18n.t(:new_resource_success, resource: I18n.t(:employee).downcase)
    redirect_to employee_path @employee
  end


  private

  def employee_params_create
    params.require(:employee).permit(:username, :email, :role, :password, :password_confirmation, :enterprise)
  end
end

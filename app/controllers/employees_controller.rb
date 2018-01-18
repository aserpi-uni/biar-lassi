class EmployeesController < ApplicationController
  before_action :set_employee, only: %i[show edit update destroy lock unlock]

  def show
    authorize @employee
  end

  def new
    authorize Employee
    @employee = Employee.new

    @employee.enterprise = Enterprise.find_by(name: session['enterprise.created']) if session.key? 'enterprise.created'
  end

  def create
    authorize Employee
    params = params_create

    @employee = Employee.from_params(params)
    return render :new unless @employee.save

    UserMailer.new_email(@employee).deliver_later
    flash[:success] = I18n.t(:resource_create_success, resource: Employee.model_name.human)
    redirect_to employee_path @employee
  end

  def edit
    authorize @employee
  end

  def update
    authorize @employee

    return render :edit unless @employee.update(params_update)

    flash[:success] = I18n.t(:resource_edit_success, name: @employee.username)
    redirect_to edit_employee_path(@employee)
  end

  def destroy
    authorize @employee

    @employee.soft_delete

    if @employee == current_employee
      sign_out current_employee
      flash[:success] = I18n.t(:deleted)
    else
      flash[:success] = I18n.t(:deleted_other)
    end

    redirect_to root_path
  end

  def lock
    authorize @employee

    @employee.soft_lock

    if @employee != current_employee
      flash[:success] = I18n.t(:locked_success, usr: @employee.username)
      redirect_to edit_employee_path(@employee)
    else
      redirect_to root_path
    end
  end

  def unlock
    authorize @employee

    @employee.soft_lock

    flash[:success] = I18n.t(:unlocked_success, usr: @employee.username)
    redirect_to edit_employee_path(@employee)
  end

  private

  def params_create
    p = params.require(:employee).permit(:username, :email, :role, :enterprise)
    p[:enterprise] = current_employee.enterprise.name if current_employee

    p
  end

  def params_update
    params.require(:employee).permit(:email, :role, :password, :password_confirmation)
  end

  def set_employee
    @employee = Employee.find_by!(username: params[:username])
  end
end

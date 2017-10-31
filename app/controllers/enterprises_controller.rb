class EnterprisesController < ApplicationController
  def show
    @enterprise = Enterprise.find_by! name: params[:name]
  end

  def new
    authorize Enterprise
    @enterprise = Enterprise.new
  end

  def create
    authorize Enterprise

    @enterprise = Enterprise.new(enterprise_params_create)
    return render new_enterprise_path unless @enterprise.save

    flash[:success] = I18n.t(:resource_create_success, resource: I18n.t(:enterprise).downcase)
    session['enterprise.created'] = @enterprise.name
    redirect_to new_employee_path
  end

  def edit
    @enterprise = Enterprise.find_by(name: params[:name])
    authorize @enterprise
  end

  def update
    @enterprise = Enterprise.find_by(name: params[:name])
    authorize @enterprise

    old_suffix = @enterprise.username_suffix

    return render :edit unless @enterprise.update(enterprise_params_update)

    flash[:success] = I18n.t(:resource_edit_success, name: @enterprise.name)

    if old_suffix != @enterprise.username_suffix
      employees = Employee.where(enterprise_id: @enterprise.id)
      employees.find_each { |employee| employee.update_suffix }
      flash[:notice] = I18n.t(:username_edited, count: employees.count)
    end

    redirect_to edit_enterprise_path(@enterprise)
  end


  private

  def enterprise_params_create
    params.require(:enterprise).permit(:name, :username_suffix)
  end

  def enterprise_params_update
    if current_admin
      params.require(:enterprise).permit(:avatar, :description, :founded, :headquarters, :name, :username_suffix, :website)
    else
      params.require(:enterprise).permit(:avatar, :description, :founded, :headquarters, :website)
    end
  end
end

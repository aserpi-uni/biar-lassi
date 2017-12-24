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

    if old_suffix != @enterprise.username_suffix
      employees = @enterprise.employees
      employees.find_each(&:update_suffix)
      flash[:notice] = I18n.t(:username_edited, count: employees.count)
    end

    flash[:success] = I18n.t(:resource_edit_success, name: @enterprise.name)
    redirect_to edit_enterprise_path(@enterprise)
  end

  def destroy
    @enterprise = Enterprise.find_by(name: params[:name])
    authorize @enterprise

    @enterprise.soft_delete

    flash[:success] = I18n.t(:deleted_resource, res: @enterprise.class.name)
    flash[:notice] =  I18n.t(:deleted_enterprise, empl: @enterprise.employees.count, pro: @enterprise.products.count)

    redirect_to enterprise_path(@enterprise)
  end

  def products
    @enterprise = Enterprise.find_by(name: params[:name])
    @products = @enterprise.products.order(:model).page(params[:page])
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

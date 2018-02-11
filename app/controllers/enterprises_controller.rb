class EnterprisesController < ApplicationController
  before_action :set_enterprise, only: %i[show edit update destroy products]

  def show
    authorize @enterprise
  end

  def new
    authorize Enterprise
    @enterprise = Enterprise.new
  end

  def create
    authorize Enterprise

    @enterprise = Enterprise.new(params_create)
    return render new_enterprise_path unless @enterprise.save

    flash[:success] = I18n.t(:resource_create_success, resource: Enterprise.model_name.human)
    session['enterprise.created'] = @enterprise.name
    redirect_to new_employee_path
  end

  def edit
    authorize @enterprise
  end

  def update
    authorize @enterprise

    return render :edit unless (res = @enterprise.update(params_update))

    flash[:notice] = I18n.t(:username_edited, count: res) unless res.zero?
    flash[:success] = I18n.t(:resource_edit_success, name: @enterprise.name)
    redirect_to edit_enterprise_path(@enterprise)
  end

  def destroy
    authorize @enterprise

    @enterprise.soft_delete

    flash[:success] = I18n.t(:deleted_resource, res: Enterprise.model_name.human)
    flash[:notice] =  I18n.t(:deleted_enterprise, empl: @enterprise.employees.count, pro: @enterprise.products.count)

    redirect_to enterprise_path(@enterprise)
  end

  def products
    authorize @enterprise
  end

  private

  def params_create
    params.require(:enterprise).permit(:name, :username_suffix)
  end

  def params_update
    if current_admin
      params.require(:enterprise).permit(:avatar_operator, :avatar_supervisor, :description, :founded, :headquarters,
                                         :image, :name, :username_suffix, :website)
    else
      params.require(:enterprise).permit(:avatar_operator, :avatar_supervisor, :description, :founded, :headquarters,
                                         :image, :website)
    end
  end

  def set_enterprise
    @enterprise = Enterprise.find_by!(name: params[:name])
  end
end

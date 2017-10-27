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

    flash[:success] = I18n.t(:new_resource_success, resource: I18n.t(:enterprise).downcase)
    session['enterprise.created'] = @enterprise.name
    redirect_to new_employee_path
  end


  private

  def enterprise_params_create
    params.require(:enterprise).permit(:name, :username_suffix)
  end
end

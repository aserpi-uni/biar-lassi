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
    if @enterprise.save
      flash[:success] = I18n.t(:new_resource_success, resource: I18n.t(:enterprise).downcase)
      flash[:notice] =I18n.t(:enterprise_name, name: @enterprise.name)
      redirect_to new_employee_path
    else
      render new_enterprise_path
    end
  end


  private

  def enterprise_params_create
    params.require(:enterprise).permit(:name, :username_suffix)
  end
end

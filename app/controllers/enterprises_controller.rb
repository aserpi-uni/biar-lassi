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
      redirect_to enterprise_path @enterprise
    else
      render 'new'
    end
  end


  private

  def enterprise_params_create
    params.require(:enterprise).permit(:name, :nickname_suffix)
  end
end

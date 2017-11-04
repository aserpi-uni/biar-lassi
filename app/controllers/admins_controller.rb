class AdminsController < ApplicationController
  def show
    @admin = Admin.find_by! username: params[:username]
  end

  # TODO: test
  def new
    authorize Admin
    @admin = Admin.new
  end

  def create
    authorize Admin
    params = admin_params_create
    params[:username] = "#{params[:username]}@admin"

    @admin = Admin.create(params)
    return render :new unless @admin.valid?

    flash[:success] = I18n.t(:resource_create_success, resource: I18n.t(:admin).downcase)
    redirect_to admin_path @admin
  end

  private

  def admin_params_create
    params.require(:admin).permit(:username, :email, :password, :password_confirmation)
  end
end

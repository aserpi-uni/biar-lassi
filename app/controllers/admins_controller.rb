class AdminsController < ApplicationController
  before_action :set_admin, only: %i[show edit update destroy lock unlock]

  def show; end

  def new
    authorize Admin
    @admin = Admin.new
  end

  def create
    authorize Admin
    params = params_create

    @admin = Admin.from_params(params)
    return render :new unless @admin.save

    UserMailer.new_email(@admin).deliver_later
    flash[:success] = I18n.t(:resource_create_success, resource: Admin.model_name.human)
    redirect_to admin_path @admin
  end

  def edit
    authorize @admin
  end

  def update
    authorize @admin

    return render :edit unless @admin.update(params_update)

    flash[:success] = I18n.t(:resource_edit_success, name: @admin.username)
    redirect_to edit_admin_path(@admin)
  end

  def destroy
    authorize @admin

    @admin.soft_delete

    if @admin == current_admin
      sign_out current_admin
      flash[:success] = I18n.t(:deleted)
    else
      flash[:success] = I18n.t(:deleted_other)
    end

    redirect_to root_path
  end

  def lock
    authorize @admin

    @admin.soft_lock

    if @admin != current_admin
      flash[:success] = I18n.t(:locked_success, usr: @admin.username)
      redirect_to edit_admin_path(@admin)
    else
      redirect_to root_path
    end
  end

  def unlock
    authorize @admin

    @admin.soft_unlock

    flash[:success] = I18n.t(:unlocked_success, usr: @admin.username)
    redirect_to edit_admin_path(@admin)
  end

  private

  def params_create
    params.require(:admin).permit(:username, :email)
  end

  def params_update
    params.require(:admin).permit(:email, :password, :password_confirmation)
  end

  def set_admin
    @admin = Admin.find_by!(username: params[:username])
  end
end

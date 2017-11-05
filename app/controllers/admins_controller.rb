class AdminsController < ApplicationController
  def show
    @admin = Admin.find_by! username: params[:username]
  end

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

  def edit
    @admin = Admin.find_by(username: params[:username])
    authorize @admin
  end

  def update
    @admin = Admin.find_by(username: params[:username])
    authorize @admin

    return render :edit unless @admin.update(admin_params_update)

    flash[:success] = I18n.t(:resource_edit_success, name: @admin.username)
    redirect_to edit_admin_path(@admin)
  end

  def destroy
    @admin = Admin.find_by(username: params[:username])
    authorize @admin

    @admin.email = nil
    @admin.locked_at = Time.now

    @admin.save validate: false
    flash[:success] = I18n.t(@admin == current_admin ? :deleted : :deleted_other)
    redirect_to root_path
  end

  def lock
    @admin = Admin.find_by(username: params[:username])
    authorize @admin

    @admin.update(locked_at: Time.now)
    if @admin != current_admin
      flash[:success] = I18n.t(:locked_success, usr: @admin.username)
      redirect_to edit_admin_path(@admin)
    else
      redirect_to root_path
    end
  end

  def unlock
    @admin = Admin.find_by(username: params[:username])
    authorize @admin

    @admin.update(locked_at: nil)

    flash[:success] = I18n.t(:unlocked_success, usr: @admin.username)
    redirect_to edit_admin_path(@admin)
  end


  private

  def admin_params_create
    params.require(:admin).permit(:username, :email, :password, :password_confirmation)
  end

  def admin_params_update
    params.require(:admin).permit(:email, :password, :password_confirmation)
  end
end

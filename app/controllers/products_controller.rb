class ProductsController < ApplicationController
  before_action :set_product, only: %i[show edit update destroy restore]

  # TODO: test
  def index
    @products = policy_scope(Product).order(:model).page(params[:page])
  end

  def show
    @problem_thread = @product.problem_threads.build
    @problem_threads = @product.problem_threads.page(params[:page])
  end

  def new
    authorize Product
    @product = current_employee.enterprise.products.build
  end

  def create
    authorize Product

    @product = current_employee.enterprise.products.build(params_create)
    if @product.save
      flash[:success] = I18n.t(:resource_create_success, resource: I18n.t(:product).downcase)
      redirect_to @product
    else
      render :new
    end
  end

  def edit
  authorize @product
  end

  def update
    authorize @product
    if @product.update(params_update)
      flash[:success] = I18n.t(:resource_edit_success, name: "#{@product.enterprise.name} #{@product.model}")
      redirect_to @product
    else
      render :edit
    end
  end

  # TODO: test
  def destroy
    authorize @product
    @product.soft_delete

    flash[:success] = I18n.t(:deleted_resource, res: I18n.t(:product))
    redirect_to products_url
  end

  # TODO: test
  def restore
    authorize @product
    @product.soft_restore

    flash[:success] = I18n.t(:resource_restored, name: "#{@product.enterprise.name} #{@product.model}")
    redirect_to edit_product_path(@product)
  end

  # TODO: test
  def search
    @products = policy_scope(Product).search(params[:search],
                                             fields: ['enterprise^10', :model], operator: :or,
                                             order: { _score: :desc },
                                             page: params[:page])
    @search = params[:search]
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def params_create
    p = params.require(:product).permit(:model, :description, :production_year, :image)
    p[:active] = true

    p
  end

  def params_update
    params.require(:product).permit(:model, :description, :production_year, :image)
  end
end

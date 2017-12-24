class ProductsController < ApplicationController
  before_action :set_product, only: %i[show edit update destroy]

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

    @product = current_employee.enterprise.products.build(product_params)
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
    if @product.update(product_params)
      flash[:success] = I18n.t(:resource_edit_success, name: "#{@product.enterprise.name} #{@product.model}")
      redirect_to @product
    else
      render :edit
    end
  end

  def destroy
    authorize @product
    @product.destroy

    flash[:success] = I18n.t(:resource_destroy_success, name: "#{@product.enterprise.name} #{@product.model}")
    redirect_to products_url
  end

  def search
    @products = policy_scope(Product).search(params[:search], fields: [:model], page: params[:page])
    @search = params[:search]
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def product_params
    params.require(:product).permit(:model, :description, :production_year, :image)
  end
end

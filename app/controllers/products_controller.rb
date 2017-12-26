class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user, only: [:create, :edit, :destroy]
  before_action :check_supervisor?, only: [:new, :create, :edit, :destroy]
  before_action :find_enterprise

  # GET /products
  # GET /products.json

  def search
    if params[:search].present?
      @products = Product.search(params[:search])
    else
      @products = Product.all
    end
  end
  def index
    @products = Product.all
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @problem_thread = @product.problem_threads.build
    @problem_threads = @product.problem_threads.paginate(page: params[:page])
  end

  # GET /products/new
  def new
    @product = @enterprise.products.build
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    if @enterprise == nil
      flash[:error] = "You don't have required permissions"
      if !logged_in?
        redirect_to root
      else
        redirect_to current_user
      end
    else
    @product = @enterprise.products.build(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
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

    def check_employee
      not_permitted unless current_user.is_a?Employee
    end

    def check_supervisor?
      if current_user.is_a?Employee
        not_permitted unless current_user.role == "supervisor"
      else
        not_permitted
      end
    end

    def not_permitted
      flash[:error] = "You don't have required permissions"
      redirect_to products_path
    end

    def find_enterprise
      if current_user.is_a?Employee
        @enterprise = current_user.enterprise
      else
        @enterprise = nil
      end
    end
end

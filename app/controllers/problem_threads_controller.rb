class ProblemThreadsController < ApplicationController
  before_action :set_problem_thread, only: %i[show edit update destroy follow]
  before_action :set_product, only: %i[index new create]

  def index
    authorize @product.problem_threads.first_or_create
  end

  def show
    authorize @problem_thread
    @problem_thread.comments.order(:created_at).page(params[:page])
  end

  def new
    @problem_thread = @product.problem_threads.build
    authorize @problem_thread
  end

  def create
    authorize @product.problem_threads.build

    @problem_thread = @product.problem_threads.build(params_create)
    if @problem_thread.save
      flash[:success] = I18n.t(:resource_create_success, resource: ProblemThread.model_name.human)
      redirect_to @problem_thread
    else
      render :new
    end
  end

  def edit
    authorize @problem_thread
  end

  def update
    authorize @problem_thread

    if @problem_thread.update(permitted_attributes(@problem_thread))
      flash[:success] = I18n.t(:resource_edit_success, name: @problem_thread.title)
      redirect_to problem_thread_path(@problem_thread)
    else
      render :edit
    end
  end

  def destroy
    @problem_thread.destroy

    flash[:success] = I18n.t(:deleted_resource, res: ProblemThread.model_name.human)
    redirect_to product_problem_threads_url
  end

  def follow
    authorize @problem_thread

    if current_consumer.follow? @problem_thread
      current_consumer.unfollow @problem_thread
    else
      current_consumer.follow @problem_thread
    end

    render :show
  end

  private

  def params_create
    p = permitted_attributes(@product.problem_threads.build)

    p[:consumer] = current_consumer
    # TODO: p[:employee] = Employee.get_up(@problem_thread.product)
    p[:employee] = Employee.where(enterprise: @product.enterprise, role: :operator).first
    p[:product] = @product

    p
  end

  def set_problem_thread
    @problem_thread = ProblemThread.find(params[:id])
  end

  def set_product
    @product = Product.find(params[:product_id])
  end
end

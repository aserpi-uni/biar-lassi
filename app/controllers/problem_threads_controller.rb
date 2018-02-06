class ProblemThreadsController < ApplicationController
  before_action :set_problem_thread, only: %i[show edit update destroy down down_votes follow up]
  before_action :set_product, only: %i[index new create search]

  def index
    authorize @product.problem_threads.first_or_create
  end

  def show
    authorize @problem_thread
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

  def down
    authorize @problem_thread
  end

  def down_votes
    authorize @problem_thread
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

  def search
    authorize @product.problem_threads.first_or_create

    @problem_threads = @product.problem_threads.search(params[:search],
                                                       fields: ['title^100', 'content^10', :comments], operator: :or,
                                                       order: { _score: :desc },
                                                       page: params[:page])
    @search = params[:search]
  end

  def up
    authorize @problem_thread
    @problem_thread.up_votes.build(upper: current_user)
    @problem_thread.save
    redirect_to problem_thread_path(@problem_thread)
  end

  private

  def params_create
    p = permitted_attributes(@product.problem_threads.build)

    p[:author] = current_consumer
    p[:employee] = @product.assign_operator_problem_thread
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

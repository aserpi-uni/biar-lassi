class AdviceThreadsController < ApplicationController
  before_action :set_advice_thread, only: %i[show edit update destroy down down_votes follow up]
  before_action :set_product, only: %i[index new create search]

  def index
    authorize @product.advice_threads.first_or_create
  end

  def show
    authorize @advice_thread
  end

  def new
    @advice_thread = @product.advice_threads.build
    authorize @advice_thread
  end

  def create
    authorize @product.advice_threads.build

    @advice_thread = @product.advice_threads.build(params_create)
    if @advice_thread.save
      flash[:success] = I18n.t(:resource_create_success, resource: AdviceThread.model_name.human)
      redirect_to @advice_thread
    else
      render :new
    end
  end

  def edit
    authorize @advice_thread
  end

  def update
    authorize @advice_thread

    if @advice_thread.update(permitted_attributes(@advice_thread))
      flash[:success] = I18n.t(:resource_edit_success, name: @advice_thread.title)
      redirect_to advice_thread_path(@advice_thread)
    else
      render :edit
    end
  end

  def down
    authorize @advice_thread
  end

  def down_votes
    authorize @advice_thread
  end

  def follow
    authorize @advice_thread

    if current_consumer.follow? @advice_thread
      current_consumer.unfollow @advice_thread
    else
      current_consumer.follow @advice_thread
    end

    render :show
  end

  def search
    authorize @product.advice_threads.first_or_create

    @advice_threads = @product.advice_threads.search(params[:search],
                                                     fields: ['title^10', :content], operator: :or,
                                                     order: { _score: :desc },
                                                     page: params[:page])
    @search = params[:search]
  end

  def up
    authorize @advice_thread
    @advice_thread.up_votes.build(upper: current_user)
    @advice_thread.save
    redirect_to advice_thread_path(@advice_thread)
  end

  private

  def params_create
    p = permitted_attributes(@product.advice_threads.build)

    p[:author] = current_consumer
    p[:product] = @product

    p
  end

  def set_advice_thread
    @advice_thread = AdviceThread.find(params[:id])
  end

  def set_product
    @product = Product.find(params[:product_id])
  end
end

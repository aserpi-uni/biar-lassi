class AdviceThreadsController < ApplicationController
  before_action :set_advice_thread, only: [:show, :edit, :update, :destroy]
  before_action :set_product
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :is_consumer?, only: [:create]
  before_action :correct_user, only:[:destroy]



  # GET /problem_threads
  # GET /problem_threads.json
  #def index
  # @problem_threads = ProblemThread.all
  #end

  # GET /problem_threads/1
  # GET /problem_threads/1.json
  def show
    @comment = @advice_thread.comments.build
    @comments = @advice_thread.comments.paginate(page: params[:page])
  end

  # GET /problem_threads/new
  def new
    @advice_thread = AdviceThread.new
  end

  # GET /problem_threads/1/edit
  def edit
  end

  # POST /problem_threads
  # POST /problem_threads.json
  def create
    @advice_thread = @product.advice_threads.build(advice_thread_params)
    #@problem_thread.product = @product
    @advice_thread.consumer = current_user if current_user

    respond_to do |format|
      if @advice_thread.save
        format.html { redirect_to product_advice_thread_path(@product, @advice_thread), notice: 'Advice thread was successfully created.' }
        format.json { render :show, status: :created, location: product_advice_thread_path(@product, @advice_thread) }
      else
        format.html { render :new }
        format.json { render json: @advice_thread.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /advice_threads/1
  # PATCH/PUT /advice_threads/1.json
  def update
    respond_to do |format|
      if @advice_thread.update(advice_thread_params)
        format.html { redirect_to product_advice_thread_path(@product, @advice_thread), notice: 'Advice thread was successfully updated.' }
        format.json { render :show, status: :ok, location: product_advice_thread_path(@product, @advice_thread) }
      else
        format.html { render :edit }
        format.json { render json: @advice_thread.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /advice_threads/1
  # DELETE /advice_threads/1.json
  def destroy
    @advice_thread.destroy
    respond_to do |format|
      format.html { redirect_to product_problem_threads_url, notice: 'Problem thread was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_advice_thread
    @advice_thread = AdviceThread.find(params[:id])
  end

  def is_consumer?
    not_consumer unless current_user.is_a?Consumer
  end

  def not_consumer
    if logged_in?
      flash[:error] = "You don't have required permissions. Only consumers can make this action"
    else
      flash[:error] = "You're not logged in. Please log in or register."
    end
    redirect_to @product
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def advice_thread_params
    params.require(:advice_thread).permit(:title, :content)
  end

  def set_product
    @product = Product.find(params[:product_id])
  end


  def correct_user
    @advice_thread = current_user.advice_threads.find_by(id: params[:id])
    redirect_to product_advice_threads_url, notice:"You're not the owner of the thread"  if @advice_thread.nil?
  end


end

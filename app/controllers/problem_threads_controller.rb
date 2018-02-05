class ProblemThreadsController < ApplicationController
  before_action :set_problem_thread, only: [:show, :edit, :update, :destroy, :followers]
  before_action :set_product
  before_action :set_employee
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
    @comment = @problem_thread.comments.build
    @comments = @problem_thread.comments.paginate(page: params[:page])
  end

  # GET /problem_threads/new
  def new
    @problem_thread = ProblemThread.new
  end

  # GET /problem_threads/1/edit
  def edit
  end

  # POST /problem_threads
  # POST /problem_threads.json
  def create
    @problem_thread = @product.problem_threads.build(problem_thread_params)
    #@problem_thread.product = @product
    @problem_thread.consumer = current_user if current_user
    @problem_thread.employee = @employee

    respond_to do |format|
      if @problem_thread.save
        @problem_thread.consumer.follow(@problem_thread)
        @employee.increment(:assigned_problems, by = 1)
        ReferentNotifierMailer.new_referent_notify(@employee, @problem_thread, @product).deliver
        format.html { redirect_to product_problem_thread_path(@product, @problem_thread), notice: 'Problem thread was successfully created.' }
        format.json { render :show, status: :created, location: product_problem_thread_path(@product, @problem_thread) }
      else
        format.html { render :new }
        format.json { render json: @problem_thread.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /problem_threads/1
  # PATCH/PUT /problem_threads/1.json
  def update
    respond_to do |format|
      if @problem_thread.update(problem_thread_params)
        format.html { redirect_to product_problem_thread_path(@product, @problem_thread), notice: 'Problem thread was successfully updated.' }
        format.json { render :show, status: :ok, location: product_problem_thread_path(@product, @problem_thread) }
      else
        format.html { render :edit }
        format.json { render json: @problem_thread.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /problem_threads/1
  # DELETE /problem_threads/1.json
  def destroy
    @problem_thread.destroy
    respond_to do |format|
      format.html { redirect_to product_problem_threads_url, notice: 'Problem thread was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def followers
    @title = "Followers"
    #@problem_thread  = ProblemThread.find(params[:id])
    @consumers = @problem_thread.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_problem_thread
      @problem_thread = ProblemThread.find(params[:id])
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
    def problem_thread_params
      params.require(:problem_thread).permit(:title, :content)
    end

    def set_product
      @product = Product.find(params[:product_id])
    end

    def set_employee
      @employee = Employee.where(enterprise: @product.enterprise).order(:assigned_problems).first
    end

  def correct_user
    @problem_thread = current_user.problem_threads.find_by(id: params[:id])
    redirect_to product_problem_threads_url, notice:"You're not the owner of the thread"  if @problem_thread.nil?
  end


end

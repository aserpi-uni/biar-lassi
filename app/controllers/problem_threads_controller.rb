class ProblemThreadsController < ApplicationController
  before_action :set_problem_thread, only: [:show, :edit, :update, :destroy]

  # GET /problem_threads
  # GET /problem_threads.json
  def index
    @problem_threads = ProblemThread.all
  end

  # GET /problem_threads/1
  # GET /problem_threads/1.json
  def show
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
    @problem_thread = ProblemThread.new(problem_thread_params)

    respond_to do |format|
      if @problem_thread.save
        format.html { redirect_to @problem_thread, notice: 'Problem thread was successfully created.' }
        format.json { render :show, status: :created, location: @problem_thread }
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
        format.html { redirect_to @problem_thread, notice: 'Problem thread was successfully updated.' }
        format.json { render :show, status: :ok, location: @problem_thread }
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
      format.html { redirect_to problem_threads_url, notice: 'Problem thread was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_problem_thread
      @problem_thread = ProblemThread.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def problem_thread_params
      params.require(:problem_thread).permit(:title, :content)
    end
end

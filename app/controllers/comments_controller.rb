class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :set_problem_thread


  # GET /comments/new
  def new
    @comment = @problem_thread.comments.build
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = @problem_thread.comments.build(comment_params)


      if @comment.save
        redirect_to product_problem_thread_path(@problem_thread.product, @problem_thread)
        flash[:success] = 'Comment successfully created!'
      else
        redirect_to product_problem_thread_path(@problem_thread.product, @problem_thread)
        flash[:success] = 'Comment successfully created!'

      end

  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update

      if @comment.update(comment_params)
        redirect_to product_problem_thread_path(@problem_thread.product, @problem_thread)
        flash[:success] = 'Comment successfully updated!'
      else
        redirect_to product_problem_thread_path(@problem_thread.product, @problem_thread)
        flash[:error] = 'Comment NOT updated'
      end

  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy

      redirect_to product_problem_thread_path(@problem_thread.product, @problem_thread)
      flash[:success] = 'Comment successfully destroyed!'

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:content)
    end

    def set_problem_thread
      @problem_thread = ProblemThread.find(params[:problem_thread_id])
    end
end

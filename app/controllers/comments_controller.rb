class CommentsController < ApplicationController
  before_action :set_comment, only: %i[edit update destroy down down_votes mark up]
  before_action :set_domain, only: %i[new create]

  def new
    @comment = @domain.comments.new
    authorize @comment
  end

  def create
    @comment = @domain.comments.build(params_create)
    authorize @comment

    if @comment.save
      flash[:success] = I18n.t(:resource_create_success, resource: Comment.model_name.human)
      redirect_to comment_path(@comment)
    else
      render :new
    end
  end

  def edit
    authorize @comment
  end

  def update
    authorize @comment

    if @comment.update(params_update)
      flash[:success] = I18n.t(:resource_edit_success, name: Comment.model_name.human)
      redirect_to comment_path(@comment)
    else
      render :edit
    end
  end

  def down
    authorize @comment
  end

  def down_votes
    authorize @comment
  end

  def mark
    authorize @comment
    @comment.update(solution: !@comment.solution)

    if @comment.solution
      flash[:success] = I18n.t(:solution_marked)

      @comment.domain.followers.where.not(email: [nil, '']).each do |follower|
        ConsumerNotifierMailer.new_solution(@comment, follower).deliver_later
      end
      ReferentNotifierMailer.new_solution(@comment).deliver_later
    else
      flash[:success] = I18n.t(:solution_unmarked)
    end
    redirect_to comment_path(@comment)
  end

  def up
    authorize @comment
    @comment.up_votes.build(upper: current_user)
    @comment.save
    redirect_to comment_path(@comment)
  end

  private

  def params_create
    p = permitted_attributes(@domain.comments.new)
    p[:author] = current_user
    p[:solution] = false

    p
  end

  def params_update
    permitted_attributes(@comment)
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def set_domain
    @domain = if params[:problem_thread_id]
                ProblemThread.find(params[:problem_thread_id])
              else
                AdviceThread.find(params[:advice_thread_id])
              end
  end
end

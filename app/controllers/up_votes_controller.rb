class UpVotesController < ApplicationController
  def destroy
    @up = UpVote.find(params[:id])
    authorize @up

    if @up.uppable.is_a?(Comment)
      redirect_to comment_path(@up.uppable)
    else
      redirect_to problem_thread_path(@up.uppable)
    end

    @up.destroy
  end
end

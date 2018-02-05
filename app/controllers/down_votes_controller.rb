class DownVotesController < ApplicationController
  def create
    p = params.require(:down_vote).permit(:downable_type, :downable_id, :reason)

    res = p[:downable_type]&.constantize&.find(p[:downable_id])

    @down = current_user.down_votes.build(downable: res, reason: p[:reason])
    authorize @down
    @down.save

    if @down.downable.is_a?(Comment)
      redirect_to comment_path(@down.downable)
    else
      redirect_to @down.downable
    end
  end

  def destroy
    @down = DownVote.find(params[:id])
    authorize @down
    @down.destroy

    if @down.downable.is_a?(Comment)
      redirect_to comment_path(@down.downable)
    else
      redirect_to @down.downable
    end
  end
end

class DownVotePolicy < ApplicationPolicy
  attr_reader :user, :down

  def initialize(user, down)
    @user = user
    @down = down
  end

  def create?
    (@user.is_a?(Consumer) || (@user.is_a?(Employee) && @user.same_enterprise?(@down.downable))) &&
      @user != @down.downable.author &&
      @down.downable.down_votes.where(downer: @user).empty?
  end

  def destroy?
    @user == @down.downer || @user.is_a?(Admin)
  end
end

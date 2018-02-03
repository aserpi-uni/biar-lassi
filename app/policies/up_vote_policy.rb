class UpVotePolicy < ApplicationPolicy
  attr_reader :user, :up

  def initialize(user, up)
    @user = user
    @up = up
  end

  def destroy?
    @user == @up.upper || @user.is_a?(Admin)
  end
end

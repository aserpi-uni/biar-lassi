class DownVote < ApplicationRecord
  after_create :decrement_votes, :remove_up_vote
  after_destroy :increment_votes

  belongs_to :downer, polymorphic: true
  belongs_to :downable, polymorphic: true

  validates :downable_id, uniqueness: { scope: %i[downable_type downer_id downer_type] }
  validates :reason, length: { in: 6..120 }

  private

  def decrement_votes
    downable.decrement!(:votes)
  end

  def increment_votes
    downable.increment!(:votes)
  end

  def remove_up_vote
    downable.up_votes.find_by(upper: downer)&.destroy
  end
end

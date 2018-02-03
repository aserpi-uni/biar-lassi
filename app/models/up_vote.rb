class UpVote < ApplicationRecord
  after_create :increment_votes, :remove_down_vote
  after_destroy :decrement_votes

  belongs_to :upper, polymorphic: true
  belongs_to :uppable, polymorphic: true

  validates :uppable_id, uniqueness: { scope: %i[uppable_type upper_id upper_type] }

  private

  def decrement_votes
    uppable.decrement!(:votes)
  end

  def increment_votes
    uppable.increment!(:votes)
  end

  def remove_down_vote
    uppable.down_votes.find_by(downer: upper)&.destroy
  end
end

# Answer to a problem thread.
#
# *Parameters:*
# * +content+ [String]      content of the answer
# * +votes+ [Integer]       algebraic sum of the votes of the problem thread
# * +solution+ [Boolean]    indicates if the comments is a solution for the problem thread
#
# *Associations:*
# * +belongs_to+ [Author polymorphic]    author of the comment
# * +belongs_to+ [ProblemThread]         problem thread which the comment answers
# * +has_many+ [DownVote]                downvotes for the comment
# * +has_many+ [UpVote]                  upvotes for the comment
class Comment < ApplicationRecord
  after_create :notify

  belongs_to :domain, polymorphic: true
  belongs_to :author, polymorphic: true

  has_many :up_votes, as: :uppable, dependent: :destroy
  has_many :down_votes, as: :downable, dependent: :destroy

  validates :content, length: { in: 4..260 }

  private

  def notify
    return unless domain.is_a?(ProblemThread)

    domain.followers.where.not(email: [nil, '']).each do |follower|
      ConsumerNotifierMailer.comment_created(self, follower).deliver_later
    end

    ReferentNotifierMailer.comment_created(self).deliver_later unless author == domain.employee
  end
end

class Comment < ApplicationRecord
  after_create :notify

  belongs_to :author, polymorphic: true
  belongs_to :problem_thread

  has_many :up_votes, as: :uppable, dependent: :destroy
  has_many :down_votes, as: :downable, dependent: :destroy

  validates :content, length: { in: 4..260 }

  private

  def notify
    problem_thread.followers.where.not(email: [nil, '']).each do |follower|
      ConsumerNotifierMailer.comment_created(self, follower).deliver_later
    end

    ReferentNotifierMailer.comment_created(self).deliver_later unless author == problem_thread.employee
  end
end

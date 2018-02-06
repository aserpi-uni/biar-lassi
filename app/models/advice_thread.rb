class AdviceThread < ApplicationRecord
  include Threadable
  searchkick callbacks: :async

  after_update :notify_followers, if: -> { status_changed? }

  enum status: { waiting: 0, evaluating: 1, planned: 2, implemented: 3, rejected: 4 }

  has_many :relationships, as: :followed, dependent: :destroy
  has_many :followers, through: :relationships, source: :consumer

  def search_data
    {
      content: content,
      title: title
    }
  end

  private

  def notify_followers
    followers.where.not(email: [nil, '']).each do |follower|
      ConsumerNotifierMailer.status_update(self, follower).deliver_later
    end
  end
end

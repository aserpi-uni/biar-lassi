# A thread in which a Consumer receives assistance with a product.
#
# *Parameters:*
# * +content+ [String]    content of the thread
# * +title+ [String]      title of the thread
#
# *Associations:*
# * +belongs_to+ [Consumer as Author]   the consumer that posted the thread
# * +belongs_to+ [Employee]             the operator in charge of assisting the consumer
# * +belongs_to+ [Product]              the product which the consumer has a problem
# * +has_many+ [Comment]                comments to the problem thread
# * +has_many+ [Relationship]           a relationship between the thread and a consumer
class ProblemThread < ApplicationRecord
  after_create :follow_poster, :notify_referent_new
  after_update :notify_referent_update

  belongs_to :author, class_name: Consumer.name
  belongs_to :employee
  belongs_to :product

  has_many :comments, dependent: :destroy
  has_many :down_votes, as: :downable, dependent: :destroy
  has_many :up_votes, as: :uppable, dependent: :destroy

  has_many :passive_relationships, class_name: 'Relationship', foreign_key: 'followed_id', dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :follower

  validates :content, length: { in: 8..260 }
  validates :title, length: { in: 8..52 }

  private

  def follow_poster
    author.follow(self)
  end

  def notify_referent_new
    ReferentNotifierMailer.problem_thread_created(self).deliver_later
  end

  def notify_referent_update
    ReferentNotifierMailer.problem_thread_updated(self).deliver_later
  end
end

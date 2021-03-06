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
  include Threadable
  searchkick callbacks: :async

  after_create :notify_referent_new
  after_update :notify_referent_update

  belongs_to :employee

  has_many :relationships, as: :followed, dependent: :destroy
  has_many :followers, through: :relationships, source: :consumer

  def search_data
    {
      comments: comments.map(&:content),
      content: content,
      title: title
    }
  end

  private

  def notify_referent_new
    ReferentNotifierMailer.problem_thread_created(self).deliver_later
  end

  def notify_referent_update
    ReferentNotifierMailer.problem_thread_updated(self).deliver_later
  end
end

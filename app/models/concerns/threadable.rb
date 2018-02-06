# Base thread attribute and methods.
module Threadable
  extend ActiveSupport::Concern

  included do
    belongs_to :author, class_name: Consumer.name
    belongs_to :product

    has_many :comments, as: :domain, dependent: :destroy
    has_many :down_votes, as: :downable, dependent: :destroy
    has_many :up_votes, as: :uppable, dependent: :destroy

    validates :content, length: { in: 8..260 }
    validates :title, length: { in: 8..52 }

    def self.order_by_activity(product)
      left_outer_joins(:comments).where(product: product).group(:id).order("GREATEST(MAX(comments.updated_at), #{name.underscore.pluralize}.updated_at) DESC")
    end
  end

  def last_activity
    [comments.maximum(:updated_at), updated_at].max
  end

  private

  def follow_poster
    author.follow(self)
  end
end

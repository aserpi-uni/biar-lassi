class AdviceComment < ApplicationRecord
  belongs_to :advice_thread
  belongs_to :commentable, polymorphic: true
  validates :commentable_id, presence: true
  validates :commentable_type, presence: true
  validates :content, presence: true, length: {maximum: 260}
end

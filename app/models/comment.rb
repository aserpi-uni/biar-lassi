class Comment < ApplicationRecord
  belongs_to :problem_thread
  belongs_to :commentable, polymorphic: true
  validates :commentable_id, presence: true
  validates :commentable_type, presence: true
  validates :content, presence: true, length: {maximum: 260}
end

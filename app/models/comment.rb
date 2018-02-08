class Comment < ApplicationRecord
  #belongs_to :problem_thread
  belongs_to :domain, polymorphic: true
  belongs_to :commentable, polymorphic: true
  validates :domain, presence: true
  validates :commentable, presence: true
  validates :content, presence: true, length: {maximum: 260}
end

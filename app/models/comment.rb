class Comment < ApplicationRecord
  belongs_to :problem_thread
  belongs_to :commentable, polymorphic: true
end

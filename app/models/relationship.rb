class Relationship < ApplicationRecord
  belongs_to :follower, class_name: 'Consumer'
  belongs_to :followed, class_name: 'ProblemThread'
  validates :follower_id, presence: true
  validates :followed_id, presence: true
end

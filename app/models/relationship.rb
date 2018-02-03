class Relationship < ApplicationRecord
  belongs_to :follower, class_name: 'Consumer'
  belongs_to :followed, class_name: 'ProblemThread'
end

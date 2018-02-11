class Relationship < ApplicationRecord
  belongs_to :consumer
  belongs_to :followed, polymorphic: true
end

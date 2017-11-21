class Post < ApplicationRecord
  belongs_to :consumer
  default_scope -> {order(created_at: :desc)}
  validates :consumer_id, presence: true
  validates :content, presence: true, length: {maximum: 260}
end

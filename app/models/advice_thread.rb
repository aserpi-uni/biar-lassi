class AdviceThread < ApplicationRecord
  belongs_to :product
  belongs_to :consumer
  has_many :comments, as: :domain
  validates :content, presence: true, length: {maximum: 260}
end

class ProblemThread < ApplicationRecord
  belongs_to :product
  belongs_to :consumer
  has_many :comments, dependent: :destroy
end

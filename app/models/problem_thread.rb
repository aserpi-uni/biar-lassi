class ProblemThread < ApplicationRecord
  belongs_to :product
  belongs_to :consumer
  belongs_to :employee
  has_many :comments, dependent: :destroy
end

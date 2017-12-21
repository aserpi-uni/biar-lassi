class ProblemThread < ApplicationRecord
  belongs_to :product
  belongs_to :consumer
  belongs_to :employee
  has_many :comments, dependent: :destroy
  validates :product_id, presence: true
  validates :consumer_id, presence: true
  validates :employee_id, presence: true
  validates :title, presence: true
  validates :content, presence: true, length: {maximum: 260}
end

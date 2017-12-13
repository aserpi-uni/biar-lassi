class Product < ApplicationRecord
  belongs_to :enterprise
  has_many :problem_threads
end
